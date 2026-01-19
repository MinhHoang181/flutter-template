import 'dart:io';

import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:dio/io.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:template/app/app.dart';
import 'package:template/app/network/interceptors/error_interceptor.dart';
import 'package:template/app/network/interceptors/header_interceptor.dart';
import 'package:template/app/network/interceptors/log_interceptor.dart';
import 'package:template/app/services/device_info.dart';
import 'package:template/core/constants/env_constants.dart';

@Singleton()
class RestClient {
  @factoryMethod
  factory RestClient({required DotEnv dotEnv, required DeviceInfo deviceInfo}) {
    final dio = Dio();

    final BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
    );

    dio.options = options;

    dio.interceptors.add(HeaderInterceptor(deviceInfo: deviceInfo));
    dio.interceptors.add(ApiErrorInterceptor());
    dio.interceptors.add(LogInterceptor(talker: debugTalker));

    // Disable certificate check (only for trusted domain)
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.badCertificateCallback = (_, _, _) => true;
        return client;
      },
    );

    /// For response bodies greater than 50KB, a new Isolate will be spawned to
    /// decode the response body to JSON.
    dio.transformer = FusedTransformer(
      contentLengthIsolateThreshold: 50 * 1024,
    );

    return RestClient._(dotEnv, dio);
  }

  RestClient._(this._dotEnv, this.dio);

  final DotEnv _dotEnv;

  final Dio dio;

  String get baseUrl => _dotEnv.env[EnvConstants.API_URL] ?? '';
}
