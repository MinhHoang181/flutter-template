import 'package:template/core/classes/app_exception.dart';

abstract class AuthException extends AppException {
  const AuthException({required String message, required this.errorCode})
    : super(message);

  final String errorCode;
}

class InvalidAccessTokenException extends AuthException {
  const InvalidAccessTokenException()
    : super(errorCode: 'invalid_access_token', message: 'Invalid access token');
}

class InvalidRefreshTokenException extends AuthException {
  const InvalidRefreshTokenException()
    : super(
        errorCode: 'invalid_refresh_token',
        message: 'Invalid refresh token',
      );
}

class EmptyRefreshTokenException extends AuthException {
  const EmptyRefreshTokenException()
    : super(errorCode: 'empty_refresh_token', message: 'Empty refresh token');
}
