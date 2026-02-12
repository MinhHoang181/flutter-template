import 'dart:convert';
import 'dart:typed_data';

import 'package:core_extension/core_extension.dart';
import 'package:dio/dio.dart';
import 'package:talker/talker.dart';
import 'package:talker_dio_logger/dio_logs.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:template/core/constants/network_constants.dart';

const _encoder = JsonEncoder.withIndent('  ');

const _sensitiveKeys = {
  'password',
  'token',
  'access_token',
  'refresh_token',
  'otp',
  'passphrase',
  'secret',
  'secret_key',
  'api_key',
  'auth_token',
  'authorization',
  'cookie',
  'set-cookie',
  'x-auth-token',
};

class LogInterceptor extends _AppTalkerDioLogger {
  LogInterceptor({required super.talker})
    : super(
        settings: TalkerDioLoggerSettings(
          // request
          printRequestHeaders: true,
          printRequestData: true,
          printRequestExtra: false,
          // response
          printResponseHeaders: true,
          printResponseData: true,
          printResponseTime: true,
          printResponseMessage: false,
          printResponseRedirects: false,
          // error
          printErrorHeaders: true,
          printErrorData: true,
          printErrorMessage: false,
          // custom log
          hiddenHeaders: {},
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
      final message = _redactUri(options.uri).toString();
      final httpLog = _DioRequestLog(
        message,
        requestOptions: options.copyWith(
          data: _convertDataLog(options.data),
          headers: _convertDataLog(options.headers) as Map<String, dynamic>?,
          queryParameters:
              _convertDataLog(options.queryParameters) as Map<String, dynamic>?,
        ),
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
      final message = _redactUri(response.requestOptions.uri).toString();
      final httpLog = _DioResponseLog(
        message,
        settings: settings,
        response: _redactResponse(response),
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
      final message = _redactUri(err.requestOptions.uri).toString();
      final httpErrorLog = _DioErrorLog(
        message,
        dioException: DioException(
          requestOptions: err.requestOptions.copyWith(
            data: _convertDataLog(err.requestOptions.data),
            headers: _convertDataLog(err.requestOptions.headers)
                as Map<String, dynamic>?,
            queryParameters:
                _convertDataLog(err.requestOptions.queryParameters)
                    as Map<String, dynamic>?,
          ),
          response: err.response != null ? _redactResponse(err.response!) : null,
          error: err.error,
          type: err.type,
          stackTrace: err.stackTrace,
          message: err.message,
        ),
        settings: settings,
      );
      _talker.logCustom(httpErrorLog);
    } catch (_) {
      //pass
    }
  }

  Response _redactResponse(Response response) {
    return Response(
      requestOptions: response.requestOptions.copyWith(
        data: _convertDataLog(response.requestOptions.data),
        headers: _convertDataLog(response.requestOptions.headers)
            as Map<String, dynamic>?,
        queryParameters: _convertDataLog(response.requestOptions.queryParameters)
            as Map<String, dynamic>?,
      ),
      data: response.data,
      headers: _redactHeaders(response.headers),
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
    );
  }

  Headers _redactHeaders(Headers headers) {
    final redacted = Headers();
    headers.forEach((name, values) {
      if (_sensitiveKeys.contains(name.toLowerCase())) {
        redacted.set(name, '*** REDACTED ***');
      } else {
        redacted.set(name, values);
      }
    });
    return redacted;
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

Uri _redactUri(Uri uri) {
  if (uri.queryParameters.isEmpty) {
    return uri;
  }

  final params = Map<String, dynamic>.from(uri.queryParametersAll);
  bool changed = false;

  for (final key in params.keys) {
    if (_sensitiveKeys.contains(key.toLowerCase())) {
      params[key] = ['*** REDACTED ***'];
      changed = true;
    }
  }

  if (!changed) {
    return uri;
  }

  return uri.replace(queryParameters: params);
}

Object? _convertDataLog(Object? data) {
  if (data is FormData) {
    final buffer = StringBuffer();

    for (final field in data.fields) {
      final value = _sensitiveKeys.contains(field.key.toLowerCase())
          ? '*** REDACTED ***'
          : field.value;
      buffer.write('[${field.key}=$value] ');
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

  if (data is String) {
    if (data.isLooksLikeDataUriBase64) {
      return '<Data URI Base64>';
    }

    if (data.isLooksLikeRawBase64()) {
      return '<Raw Base64>';
    }

    try {
      final decoded = jsonDecode(data);
      if (decoded is Map || decoded is List) {
        return _convertDataLog(decoded);
      }
    } catch (_) {
      // Not a JSON string
    }

    return data;
  }

  if (data is Map<String, dynamic>) {
    return data.map((key, value) {
      if (_sensitiveKeys.contains(key.toLowerCase())) {
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
