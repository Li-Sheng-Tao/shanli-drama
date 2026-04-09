import 'package:dio/dio.dart';
import '../storage/storage_service.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 从本地存储获取 Token
    final token = StorageService.instance.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Token 过期，尝试刷新
      // TODO: 实现 Token 刷新逻辑
      // final newToken = await _refreshToken();
      // if (newToken != null) {
      //   final options = err.requestOptions;
      //   options.headers['Authorization'] = 'Bearer $newToken';
      //   try {
      //     final response = await Dio().fetch(options);
      //     handler.resolve(response);
      //     return;
      //   } catch (e) {
      //     // 刷新失败，跳转登录
      //   }
      // }
      StorageService.instance.clearToken();
    }
    handler.next(err);
  }
}
