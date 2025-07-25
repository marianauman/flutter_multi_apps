import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../shared/widgets/no_internet_dialog.dart';
import 'connectivity_shared_instance.dart';

class DioSharedInstance {
  static final DioSharedInstance _instance = DioSharedInstance._internal();
  factory DioSharedInstance() => _instance;

  late Dio _dio;
  Dio get dio => _dio;

  DioSharedInstance._internal() {
    _dio = _createDio();
  }

  Dio _createDio() {
    final dio = Dio();

    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 20);
    dio.options.sendTimeout = Duration(seconds: 15);
    dio.options.responseType = ResponseType.json;
    dio.options.contentType = 'application/json';

    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (obj) => kDebugMode ? debugPrint(obj.toString()) : null,
      ),
      ConnectivityInterceptor(),
      ErrorInterceptor(),
      // Add more interceptors as needed
      // AuthInterceptor(),
      // ErrorInterceptor(),
    ]);

    return dio;
  }

  // Method to update base URL
  void updateBaseUrl(String newBaseUrl) {
    _dio.options.baseUrl = newBaseUrl;
  }

  // Method to add headers globally
  void addGlobalHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  // Method to clear headers
  void clearHeaders() {
    _dio.options.headers.clear();
  }

  // Method to add auth token
  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Method to remove auth token
  void removeAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Method to add custom interceptor
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  // Method to remove all interceptors
  void clearInterceptors() {
    _dio.interceptors.clear();
  }

  // Method to get current base URL
  String get baseUrl => _dio.options.baseUrl;

  // Method to get current headers
  Map<String, dynamic> get headers => _dio.options.headers;
}

/// Interceptor to check for internet connectivity before making API requests
class ConnectivityInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final result = await ConnectivitySharedInstance().isConnected();
    if (!result) {
      showNoInternetDialog(() {
        _retryRequest(options, handler);
      });
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No Internet Connection',
        ),
      );
    } else {
      handler.next(options);
    }
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.badResponse,
          error: 'Unauthorized',
          response: err.response,
          message: err.message,
        ),
      );
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      showNoInternetDialog(() {
        _retryRequest(err.requestOptions);
      });
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.unknown,
          error: 'Timeout Error',
          response: err.response,
          message: err.message,
        ),
      );
    } else if (err.type == DioExceptionType.connectionError) {
      showNoInternetDialog(() {
        _retryRequest(err.requestOptions);
      });
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.connectionError,
          error: 'Connection Error',
          response: err.response,
          message: err.message,
        ),
      );
    } else if (err.type == DioExceptionType.badResponse) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.badResponse,
          error: 'Bad Response',
          response: err.response,
          message: err.message,
        ),
      );
    } else if (err.type == DioExceptionType.unknown) {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          type: DioExceptionType.unknown,
          error: 'Unknown Error',
          response: err.response,
          message: err.message,
        ),
      );
    }

    handler.next(err);
  }
}

Future<void> _retryRequest(
  RequestOptions options, [
  RequestInterceptorHandler? handler,
]) async {
  try {
    final isConnected = await ConnectivitySharedInstance().isConnected();
    if (!isConnected) {
      return;
    }

    // Create a new Dio instance for the retry
    final dio = Dio();
    dio.options.connectTimeout = Duration(seconds: 10);
    dio.options.receiveTimeout = Duration(seconds: 20);
    dio.options.sendTimeout = Duration(seconds: 15);
    dio.options.responseType = ResponseType.json;
    dio.options.contentType = 'application/json';
    dio.options.baseUrl = options.baseUrl;

    // Make the retry request
    final response = await dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(method: options.method, headers: options.headers),
    );

    // If we have a handler, resolve the original request
    if (handler != null) {
      handler.resolve(response);
    }
  } catch (error) {
    // If retry fails, show dialog again
    showNoInternetDialog(() {
      _retryRequest(options, handler);
    });

    // If we have a handler, reject the original request
    if (handler != null) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'Retry failed: $error',
        ),
      );
    }
  }
}
