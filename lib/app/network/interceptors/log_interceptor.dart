import 'dart:convert';
import 'dart:typed_data';

import 'package:core_extension/core_extension.dart';
import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/dio_logs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:template/core/constants/network_constants.dart';

const _encoder = JsonEncoder.withIndent('  ');

class LogInterceptor extends _AppTalkerDioLogger {
  LogInterceptor({required super.talker})
    : super(
        settings: TalkerDioLoggerSettings(
          // request
          printRequestHeaders: true,
          printRequestData: true,
          printRequestExtra: false,
          // response
          printResponseHeaders: false,
          printResponseData: true,
          printResponseTime: true,
          printResponseMessage: false,
          printResponseRedirects: false,
          // error
          printErrorHeaders: false,
          printErrorData: true,
          printErrorMessage: false,
          // custom log
          hiddenHeaders: {ApiHeaders.authorization},
          responseDataConverter: (response) {
            final data = _convertDataLog(response.data);

            return _encoder.convert(data);
          },
        ),
      );

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // implement remote log service here

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // implement remote log service here

    super.onError(err, handler);
  }
}

class _AppTalkerDioLogger extends TalkerDioLogger {
  _AppTalkerDioLogger({required Talker super.talker, super.settings})
    : _talker = talker;

  final Talker _talker;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.requestFilter?.call(options) ?? true;
    if (!accepted) {
      return;
    }
    try {
      final message = '${options.uri}';
      final httpLog = _DioRequestLog(
        message,
        requestOptions: options.copyWith(data: _convertDataLog(options.data)),
        settings: settings,
      );
      _talker.logCustom(httpLog);
    } catch (_) {
      //pass
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.responseFilter?.call(response) ?? true;
    if (!accepted) {
      return;
    }
    try {
      final message = '${response.requestOptions.uri}';
      final httpLog = _DioResponseLog(
        message,
        settings: settings,
        response: response,
      );
      _talker.logCustom(httpLog);
    } catch (_) {
      //pass
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
    if (!settings.enabled) {
      return;
    }
    final accepted = settings.errorFilter?.call(err) ?? true;
    if (!accepted) {
      return;
    }
    try {
      final message = '${err.requestOptions.uri}';
      final httpErrorLog = _DioErrorLog(
        message,
        dioException: err,
        settings: settings,
      );
      _talker.logCustom(httpErrorLog);
    } catch (_) {
      //pass
    }
  }
}

class _DioRequestLog extends DioRequestLog {
  _DioRequestLog(
    super.message, {
    required super.requestOptions,
    required super.settings,
  });

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final String msg = super.generateTextMessage(timeFormat: timeFormat);
    return '${displayTime(timeFormat: timeFormat)} | $msg';
  }
}

class _DioResponseLog extends DioResponseLog {
  _DioResponseLog(
    super.message, {
    required super.response,
    required super.settings,
  });

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final String msg = super.generateTextMessage(timeFormat: timeFormat);
    return '${displayTime(timeFormat: timeFormat)} | $msg';
  }
}

class _DioErrorLog extends DioErrorLog {
  _DioErrorLog(
    super.message, {
    required super.dioException,
    required super.settings,
  });

  @override
  String generateTextMessage({
    TimeFormat timeFormat = TimeFormat.timeAndSeconds,
  }) {
    final String msg = super.generateTextMessage(timeFormat: timeFormat);
    return '${displayTime(timeFormat: timeFormat)} | $msg';
  }
}

Object? _convertDataLog(Object? data) {
  if (data is FormData) {
    final buffer = StringBuffer();

    for (final field in data.fields) {
      buffer.write('[${field.key}=${field.value}] ');
    }

    for (final entry in data.files) {
      final file = entry.value;
      buffer.write('[${entry.key}=${file.filename}');
      if (file.contentType != null) {
        buffer.write(', type=${file.contentType}');
      }
      buffer.write('] ');
    }

    return buffer.toString().trim();
  }

  if (data is MultipartFile) {
    return '[MultipartFile: filename=${data.filename}, type=${data.contentType}]';
  }

  if (data is Uint8List) {
    return '<Binary Data: ${data.length} bytes>';
  }

  if (data is Stream) {
    return '<Stream>';
  }

  if (data is String && data.isLooksLikeDataUriBase64) {
    return '<Data URI Base64>';
  }

  if (data is String && data.isLooksLikeRawBase64()) {
    return '<Raw Base64>';
  }

  if (data is Map<String, dynamic>) {
    return data.map((key, value) {
      const sensitiveKeys = {
        'password',
        'token',
        'access_token',
        'refresh_token',
        'otp',
      };
      if (sensitiveKeys.contains(key.toLowerCase())) {
        return MapEntry(key, '*** REDACTED ***');
      }
      return MapEntry(key, _convertDataLog(value));
    });
  }

  if (data is List) {
    return data.map(_convertDataLog).toList();
  }

  return data;
}
