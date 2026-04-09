import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants/api_constants.dart';
import 'api_interceptor.dart';

class DioClient {
  DioClient._();

  static late final Dio _dio;

  static Dio get instance => _dio;

  static void init() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: ApiConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: ApiConstants.receiveTimeout),
        sendTimeout: const Duration(milliseconds: ApiConstants.sendTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 添加拦截器
    _dio.interceptors.addAll([
      ApiInterceptor(),
      if (kDebugMode) _createLogInterceptor(),
    ]);
  }

  static InterceptorsWrapper _createLogInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('--> ${options.method} ${options.uri}');
        debugPrint('Headers: ${options.headers}');
        if (options.data != null) {
          debugPrint('Body: ${options.data}');
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('<-- ${response.statusCode} ${response.requestOptions.uri}');
        debugPrint('Data: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        debugPrint('<-- ERROR ${error.response?.statusCode} ${error.requestOptions.uri}');
        debugPrint('Message: ${error.message}');
        handler.next(error);
      },
    );
  }
}
