import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:template/app/app.dart';
import 'package:template/app/mediator/mediator.dart';
import 'package:template/app/services/auth/auth_service.dart';
import 'package:template/app/services/auth/models/jwt_token.dart';
import 'package:template/core/constants/network_constants.dart';
import 'package:template/core/presentation/widgets/dialog/notify_dialog/app_notify_dialog.dart';
import 'package:template/gen/locale_keys.gen.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({required Dio retryDio, required AuthService authService})
    : _authService = authService,
      _retryDio = retryDio;

  final AuthService _authService;

  final Dio _retryDio;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final JwtToken? accessToken = await _authService.getAccessToken();

    if (accessToken == null) {
      await _authService.deauthenticate();
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.cancel,
          error: 'No access token found.',
        ),
      );
    }

    if (!options.headers.containsKey(ApiHeaders.authorization)) {
      options.headers[ApiHeaders.authorization] =
          accessToken.authorizationValue;
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if (_authService.status != AuthStatus.authorized) {
        return handler.reject(err);
      }

      final JwtToken? accessToken = await _authService.getAccessToken();

      if (accessToken == null) {
        await showEndSessionAndExit();
        return handler.reject(err);
      } else {
        try {
          final response = await _retry(err.requestOptions, accessToken);
          return handler.resolve(response);
        } catch (_) {
          return handler.next(err);
        }
      }
    }

    super.onError(err, handler);
  }

  Future<Response> _retry(
    RequestOptions requestOptions, [
    JwtToken? newAccessToken,
  ]) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      responseType: requestOptions.responseType,
      extra: requestOptions.extra,
    );

    Object? data = requestOptions.data;

    if (data is FormData) {
      data = data.clone();
    }

    if (newAccessToken != null) {
      options.headers?.update(
        ApiHeaders.authorization,
        (_) => newAccessToken.authorizationValue,
      );
    }

    _retryDio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (error.response?.statusCode == HttpStatus.unauthorized) {
            await showEndSessionAndExit();

            return handler.reject(error);
          }

          return handler.next(error);
        },
      ),
    );

    return _retryDio.request(
      requestOptions.path,
      data: data,
      queryParameters: requestOptions.queryParameters,
      options: options,
      cancelToken: requestOptions.cancelToken,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
    );
  }

  Future<void> showEndSessionAndExit() async {
    App.logDebug(
      title: '$AuthInterceptor.showEndSession',
      message: 'end session',
    );
    App.hideLoading();

    await App.showDialog(
      barrierDismissible: false,
      child: AppNotifyDialog.error(
        title: App.text(
          LocaleKeys.app.network.auth_interceptor.end_session.title,
          defaultValue: 'Lỗi truy cập',
        ),
        message: App.text(
          LocaleKeys.app.network.auth_interceptor.end_session.message,
          defaultValue: 'Phiên đăng nhập hết hạn, vui lòng đăng nhập lại',
        ),
      ),
    );

    await _authService.deauthenticate();
    await mediator.requests.send(const DeauthenticateTokenEvent());
  }
}
