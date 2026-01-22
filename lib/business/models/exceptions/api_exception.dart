import 'dart:io';

import 'package:dio/dio.dart';

import 'package:template/core/classes/app_exception.dart';
import 'package:template/gen/locale_keys.gen.dart';

import '../../../app/app.dart';

abstract class ApiException extends AppException {
  const ApiException._({
    required String message,
    required this.status,
    required this.errorCode,
  }) : super(message);

  final int? status;

  final String? errorCode;

  static ApiException? fromError(dynamic error) {
    if (error is DioException) {
      return _fromDioException(error);
    }
    if (error is SocketException) {
      return _fromSocketException(error);
    }
    return null;
  }

  static ApiException? _fromDioException(DioException dioException) {
    final int? status = dioException.response?.statusCode;
    final DioExceptionType type = dioException.type;

    switch (type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeoutException._(status: status);
      case DioExceptionType.sendTimeout:
        return SendTimeoutException._(status: status);
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeoutException._(status: status);
      case DioExceptionType.badCertificate:
        return BadCertificateException._(status: status);
      case DioExceptionType.badResponse:
        return BadResponseException._(status: status);
      case DioExceptionType.cancel:
        return null;
      case DioExceptionType.connectionError:
        return ConnectionException._(status: status);
      case DioExceptionType.unknown:
        return null;
    }
  }

  static ApiException? _fromSocketException(SocketException socketException) {
    return ConnectionException._(status: null);
  }
}

class ApiResponseException extends ApiException {
  ApiResponseException({
    required super.message,
    required super.status,
    required super.errorCode,
  }) : super._();
}

class ConnectionTimeoutException extends ApiException {
  ConnectionTimeoutException._({super.status})
    : super._(
        message: App.text(
          LocaleKeys.business.api_exception.connection_timeout,
          defaultValue:
              'Kết nối tới hệ thống mất nhiều thời gian, vui lòng thử lại sau',
        ),
        errorCode: ConnectionTimeoutException.code,
      );

  static const String code = 'connection_timeout';
}

class SendTimeoutException extends ApiException {
  SendTimeoutException._({super.status})
    : super._(
        message: App.text(
          LocaleKeys.business.api_exception.send_timeout,
          defaultValue:
              'Gửi yêu cầu tới hệ thống mất nhiều thời gian, vui lòng thử lại sau',
        ),
        errorCode: SendTimeoutException.code,
      );

  static const String code = 'send_timeout';
}

class ReceiveTimeoutException extends ApiException {
  ReceiveTimeoutException._({super.status})
    : super._(
        message: App.text(
          LocaleKeys.business.api_exception.receive_timeout,
          defaultValue:
              'Hệ thống mất nhiều thời gian phản hồi, vui lòng thử lại sau',
        ),
        errorCode: ReceiveTimeoutException.code,
      );

  static const String code = 'receive_timeout';
}

class BadCertificateException extends ApiException {
  BadCertificateException._({super.status})
    : super._(
        message: App.text(
          LocaleKeys.business.api_exception.bad_certificate,
          defaultValue:
              'Lỗi chứng chỉ kết nối không hợp lệ, vui lòng thử lại sau',
        ),
        errorCode: BadCertificateException.code,
      );

  static const String code = 'bad_certificate';
}

class BadResponseException extends ApiException {
  BadResponseException._({super.status})
    : super._(
        message: App.text(
          LocaleKeys.business.api_exception.bad_response,
          defaultValue: 'Hệ thống đang gặp sự cố, vui lòng thử lại sau',
        ),
        errorCode: BadResponseException.code,
      );

  static const String code = 'bad_response';
}

class ConnectionException extends ApiException {
  ConnectionException._({super.status})
    : super._(
        message: App.text(
          LocaleKeys.business.api_exception.connection_error,
          defaultValue: 'Lỗi kết nối mạng, vui lòng thử lại sau',
        ),
        errorCode: ConnectionException.code,
      );

  static const String code = 'connection_error';
}
