import 'package:dio/dio.dart';

class ApiErrorInterceptor extends Interceptor {
  ApiErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {} catch (_) {}

    super.onError(err, handler);
  }
}
