// Base API service

import 'package:dio/dio.dart';
import '../../main/main_common.dart';
import '../constants/app_constants.dart';
import '../shared_instances.dart/connectivity_shared_instance.dart';
import '../shared_instances.dart/dio_shared_instance.dart';

class ApiManager {
  String baseurl = appconfig.apiBaseUrl;
  final String endpoint;
  Map<String, dynamic> body;
  Map<String, String> header;
  Map<String, String> params;

  ApiManager({
    required this.endpoint,
    this.body = const {},
    this.header = const {},
    this.params = const {},
    bool includeBaseUrl = true,
  }) {
    if (!includeBaseUrl) {
      baseurl = '';
    }
    header = Map<String, String>.from(header);
    body = Map<String, dynamic>.from(body);
    params = Map<String, String>.from(params);
  }

  Future<Map<String, dynamic>> getApi() async {
    var result = await ConnectivitySharedInstance().isConnected();
    if (!result) {
      throw DioApiError.noInternet;
    }
    try {
      String url = '$baseurl$endpoint';
      final response = await DioSharedInstance().dio.get(
        url,
        queryParameters: params.isNotEmpty ? params : null,
        options: Options(headers: header),
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (e.error is DioApiError) {
          throw e.error as DioApiError;
        } else if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          throw DioApiError.noInternet;
        }
      }
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postApi() async {
    var result = await ConnectivitySharedInstance().isConnected();
    if (!result) {
      throw DioApiError.noInternet;
    }
    try {
      String url = '$baseurl$endpoint';
      final response = await DioSharedInstance().dio.post(
        url,
        data: body.isNotEmpty ? body : null,
        queryParameters: params.isNotEmpty ? params : null,
        options: Options(headers: header),
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (e.error is DioApiError) {
          throw e.error as DioApiError;
        } else if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout ||
            e.type == DioExceptionType.sendTimeout) {
          throw DioApiError.noInternet;
        }
      }
      rethrow;
    }
  }
}
