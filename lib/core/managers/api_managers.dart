// Base API service

import 'package:dio/dio.dart';
import '../../main/main_common.dart';
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
    try {
      String url = '$baseurl$endpoint';
      final response = await DioSharedInstance().dio.get(
        url,
        queryParameters: params.isNotEmpty ? params : null,
        options: Options(headers: header),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> postApi() async {
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
      rethrow;
    }
  }

  // Future<bool> _checkConnectivity({VoidCallback? onRetry}) async {
  //   bool isConnected = await _connectivityService.isConnected();
  //   if (!isConnected) {
  //     final context = navigatorKey.currentContext;
  //     if (context != null) {
  //       AppAlerts.showCustomDialog(child: NoInternetDialog(
  //           onRetry: onRetry,
  //         )
  //       );
  //     }
  //     return isConnected;
  //   }
  //   return isConnected;
  // }

  // ///Post
  // ///
  // Future<Map<String, dynamic>> postApi() async {

  //   bool isConnected = await _checkConnectivity();
  //   if (!isConnected) {
  //     return {};
  //   }

  //   try {
  //     final requestParams = params.isNotEmpty
  //         ? params
  //         : <String, String>{};

  //     final uri = Uri.parse(baseurl + endpoint);
  //     final urlWithParams = uri.replace(
  //       queryParameters: requestParams.isNotEmpty
  //         ? Map<String, String>.from(requestParams)
  //         : null
  //     );

  //     final requestBody = useEncryption
  //         ? _cryptoHelper.encryptData(jsonEncode(body))
  //         : body;

  //     PrintLogs.logInfo(convertRequestToCurl('POST', urlWithParams.toString(), header, requestBody), tag: 'REQUEST');

  //     final response = await http
  //         .post(
  //           urlWithParams,
  //           body: jsonEncode(requestBody),
  //           headers: header,
  //         )
  //         .timeout(Duration(seconds: timeOutDuration));

  //     PrintLogs.printLog(response.body,tag: 'RESPONSE');

  //     return await _handleResponse(response);

  //   } catch (e, stackTrace) {
  //     throw _handleException(e, stackTrace);
  //   }
  // }

  // ///Get
  // ///

  // Future<Map<String, dynamic>> getApi() async {

  //   bool isConnected = await _checkConnectivity(
  //     onRetry: () => getApi(),
  //   );
  //   if (!isConnected) {
  //     return {};
  //   }

  //   try {

  //     final requestParams = params.isNotEmpty
  //         ? (useEncryption
  //             ? _cryptoHelper.encryptData(jsonEncode(params))
  //             : params)
  //         : <String, String>{};

  //     final uri = Uri.parse(baseurl + endpoint);
  //     final urlWithParams = uri.replace(
  //       queryParameters: requestParams.isNotEmpty
  //         ? Map<String, String>.from(requestParams)
  //         : null
  //     );

  //     PrintLogs.logInfo(convertRequestToCurl('GET', urlWithParams.toString(), header, body), tag: 'REQUEST');

  //     final response = await http
  //         .get(
  //           urlWithParams,
  //           headers: header,
  //         )
  //         .timeout(Duration(seconds: timeOutDuration));

  //     PrintLogs.printLog(response.body, tag: 'RESPONSE');
  //     return await _handleResponse(response);

  //   } catch (e, stackTrace) {
  //     throw _handleException(e, stackTrace);
  //   }
  // }

  // ///Delete
  // ///

  // Future<Map<String, dynamic>> deleteApi() async {
  //   bool isConnected = await _checkConnectivity();
  //   if (!isConnected) {
  //     return {};
  //   }

  //   try {
  //     final requestParams = params.isNotEmpty
  //         ? (useEncryption
  //             ? _cryptoHelper.encryptData(jsonEncode(params))
  //             : params)
  //         : <String, String>{};

  //     final uri = Uri.parse(baseurl + endpoint);
  //     final urlWithParams = uri.replace(
  //       queryParameters: requestParams.isNotEmpty
  //         ? Map<String, String>.from(requestParams)
  //         : null
  //     );

  //     PrintLogs.logInfo(convertRequestToCurl('DELETE', urlWithParams.toString(), header, body), tag: 'REQUEST');

  //     final response = await http
  //         .delete(
  //           urlWithParams,
  //           headers: header,
  //         )
  //         .timeout(Duration(seconds: timeOutDuration));

  //     PrintLogs.printLog(response.body, tag: 'RESPONSE');
  //     return await _handleResponse(response);
  //   } catch (e, stackTrace) {
  //     throw _handleException(e, stackTrace);
  //   }
  // }

  // Future<Map<String, dynamic>> _handleResponse(http.Response response) async{

  //   // Check for authentication error
  //   if (response.statusCode == 401) {
  //     final authProvider = AuthProvider();
  //     authProvider.logout();
  //     throw ApiException(
  //       message: 'Authentication failed',
  //       statusCode: response.statusCode,
  //     );
  //   }

  //   dynamic decodedResponse = json.decode(response.body);

  //   if (decodedResponse is Map<String, dynamic>) {

  //     if (useEncryption &&
  //         decodedResponse.containsKey('payload') &&
  //         decodedResponse.containsKey('key')) {

  //       decodedResponse = _cryptoHelper.decryptData(Map<String, String>.from(decodedResponse));
  //     }

  //     if(useCompression &&
  //       decodedResponse['data'] is Map<String, dynamic> &&
  //       decodedResponse['data']['file_url'] is String) {

  //       final decompressedBody =  await RemoteFileDataExtractor().fetchAndDecompressData(
  //         fileUrl: decodedResponse['data']['file_url']
  //       );

  //       final Map<String, dynamic> newResponse = Map<String, dynamic>.from(decodedResponse);
  //       newResponse['data'] = decompressedBody;
  //       decodedResponse = newResponse;
  //       PrintLogs.printLog(decodedResponse, tag: 'DECOMPRESSED RESPONSE');
  //     }

  //     return decodedResponse;
  //   } else if (decodedResponse is String) {
  //     return {"value": decodedResponse};
  //   } else if (decodedResponse is List) {
  //     return {"list": decodedResponse};
  //   }

  //   throw ApiException(
  //     message: 'Invalid response format',
  //     statusCode: response.statusCode,
  //   );
  // }

  // ApiException _handleException(dynamic error, [StackTrace? stackTrace]) {
  //   if (error is TimeoutException) {
  //     return ApiException(
  //       message: 'Connection timeout: ${error.message}',
  //       statusCode: null,
  //       stackTrace: stackTrace ?? StackTrace.current
  //     );
  //   } else if (error is FormatException) {
  //     return ApiException(
  //       message: 'Format error: ${error.message}',
  //       statusCode: null,
  //       stackTrace: stackTrace ?? StackTrace.current
  //     );
  //   } else if (error is ArgumentError) {
  //     return ApiException(
  //       message: 'Invalid argument: ${error.message}',
  //       statusCode: null,
  //       stackTrace: stackTrace ?? StackTrace.current
  //     );
  //   } else if (error is ApiException) {
  //     return error;
  //   } else {
  //     return ApiException(
  //       message: 'Unknown error: $error',
  //       statusCode: null,
  //       stackTrace: stackTrace ?? StackTrace.current
  //     );
  //   }
  // }

  // String convertRequestToCurl(String method, String url, Map<String, String> headers, dynamic body) {
  //   StringBuffer curlCommand = StringBuffer('curl -X $method');

  //   headers.forEach((key, value) {
  //     curlCommand.write(' -H "$key: $value"');
  //   });

  //   curlCommand.write(' $url');

  //   if (body != null) {
  //     String bodyString = jsonEncode(body);
  //     curlCommand.write(' -d \'$bodyString\'');
  //   }

  //   return curlCommand.toString();
  // }

  // ///Multipart
  // ///
  // Future<Map<String, dynamic>> multipartApi(
  //     List<FileObject> files,
  //     {required ProgressCallback onUploadProgress,
  //     required VoidCallback onCompleted,
  //     bool hasBaseUrl = true}) async {

  //   bool isConnected = await _checkConnectivity();
  //   if (!isConnected) {
  //     return {};
  //   }

  //   String url = hasBaseUrl ? baseurl + endpoint : endpoint;
  //   Uri uri = Uri.parse(url);
  //   var request = http.MultipartRequest("POST", uri);
  //   request.headers.addAll(header);

  //   final requestBody = useEncryption
  //       ? _cryptoHelper.encryptData(jsonEncode(body))
  //       : body;

  //   // request.fields.addAll(requestBody as Map<String, String>);
  //   request.fields.addAll(Map<String, String>.from(requestBody.map((key, value) => MapEntry(key, value.toString()))));

  //   PrintLogs.logInfo(convertRequestToCurl('POST', url, header, requestBody), tag: 'REQUEST');

  //   int totalBytes = 0;
  //   int sentBytes = 0;

  //   for (var file in files) {
  //     var length = await file.file.length();
  //     totalBytes += length;
  //     var stream = http.ByteStream(file.file.openRead());
  //     var multipartFile = http.MultipartFile(file.param, stream, length,
  //         filename: basename(file.file.path));
  //     request.files.add(multipartFile);
  //   }

  //   var msStream = request.finalize();
  //   // var totalByteLength = request.contentLength;
  //   // request.contentLength = totalByteLength;

  //   Stream<List<int>> streamUpload = msStream.transform(
  //     StreamTransformer.fromHandlers(
  //       handleData: (data, sink) {
  //         sink.add(data);
  //         sentBytes += data.length;
  //         onUploadProgress(sentBytes, totalBytes);
  //       },
  //       handleError: (error, stack, sink) {
  //         throw error;
  //       },
  //       handleDone: (sink) {
  //         onCompleted();
  //         sink.close();
  //       },
  //     ),
  //   );

  //   var httpClient = HttpClient();
  //   var httpRequest = await httpClient.postUrl(uri);
  //   request.headers.forEach((name, value) {
  //     httpRequest.headers.add(name, value);
  //   });
  //   await httpRequest.addStream(streamUpload);
  //   var httpResponse = await httpRequest.close();

  //   String responseBody = await readResponseAsString(httpResponse);
  //   PrintLogs.printLog(responseBody, tag: 'RESPONSE');

  //   // Handle encrypted response similar to other methods
  //   final decodedResponse = jsonDecode(responseBody);
  //   if (decodedResponse is Map<String, dynamic>) {
  //     if (useEncryption &&
  //         decodedResponse.containsKey('payload') &&
  //         decodedResponse.containsKey('key')) {
  //       return _cryptoHelper.decryptData(Map<String, String>.from(decodedResponse));
  //     }
  //     return decodedResponse;
  //   }

  //   throw ApiException(
  //     message: 'Invalid response format',
  //     statusCode: httpResponse.statusCode,
  //   );
  // }

  // Future<String> readResponseAsString(HttpClientResponse response) {
  //   var completer = Completer<String>();
  //   var contents = StringBuffer();
  //   response.transform(utf8.decoder).listen((String data) {
  //     contents.write(data);
  //   }, onDone: () => completer.complete(contents.toString()));
  //   return completer.future;
  // }

  // Future<File?> downloadFileWithProgress(
  //     {required String url,
  //     required String fileName,
  //     required ProgressCallback onDownloadProgress}) async {

  //   bool isConnected = await _checkConnectivity();
  //   if (!isConnected) {
  //     return null;
  //   }

  //   Uri uri = Uri.parse(url);
  //   var request = http.Request("POST", uri);
  //   request.headers.addAll(header);
  //   request.body = jsonEncode(body);

  //   PrintLogs.logInfo(convertRequestToCurl('POST', url, header, body), tag: 'REQUEST');

  //   var httpClient = HttpClient();
  //   var httpRequest = await httpClient.postUrl(uri);
  //   request.headers.forEach((name, value) {
  //     httpRequest.headers.add(name, value);
  //   });
  //   httpRequest.add(utf8.encode(request.body));
  //   var httpResponse = await httpRequest.close();

  //   int byteCount = 0;
  //   int totalBytes = httpResponse.contentLength;

  //   Directory appDocDir = await getTemporaryDirectory();
  //   String appDocPath = appDocDir.path;
  //   File file = File('$appDocPath/$fileName');

  //   var raf = file.openSync(mode: FileMode.write);

  //   Completer completer = Completer<String>();

  //   httpResponse.listen(
  //     (data) {
  //       byteCount += data.length;
  //       raf.writeFromSync(data);
  //       onDownloadProgress(byteCount, totalBytes);
  //     },
  //     onDone: () {
  //       raf.closeSync();
  //       completer.complete(file.path);
  //       PrintLogs.printLog('Download completed: $fileName', tag: 'RESPONSE');
  //     },
  //     onError: (e) {
  //       raf.closeSync();
  //       file.deleteSync();
  //       completer.completeError(e);

  //       PrintLogs.printLog('Download error: $e', tag: 'ERROR');
  //     },
  //     cancelOnError: true,
  //   );

  //   return file;
  // }
}



// ///Api Exception handling class

// class ApiException implements Exception {
//   final String message;
//   final int? statusCode;
//   final StackTrace? stackTrace;
  
//   ApiException({
//     required this.message, 
//     this.statusCode, 
//     this.stackTrace,
//   });
  
//   @override
//   String toString() => 'ApiException: $message\n${stackTrace ?? ''}';
// }


//   ///multipart
//   ///
//   typedef ProgressCallback = void Function(int sentBytes, int totalBytes);
//   class FileObject {
//     File file;
//     String param;

//     FileObject({required this.file, required this.param});
//   }