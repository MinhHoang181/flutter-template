import 'dart:io';

import 'package:dio/dio.dart';

import '../../services/device_info.dart';

enum HeaderPlatform { android, ios, web, unknown }

class HeaderInterceptor extends Interceptor {
  HeaderInterceptor({required DeviceInfo deviceInfo})
    : _deviceInfo = deviceInfo;

  final DeviceInfo _deviceInfo;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final String deviceId = _deviceInfo.deviceId;

    if (deviceId.isNotEmpty) {
      options.headers.putIfAbsent('X-DEVICE-ID', () => deviceId);
    }

    final String deviceName = _deviceInfo.deviceName;
    if (deviceName.isNotEmpty) {
      options.headers.putIfAbsent('X-DEVICE-NAME', () => deviceName);
    }

    options.headers['X-PLATFORM'] = Platform.isAndroid
        ? HeaderPlatform.android.name
        : Platform.isIOS
        ? HeaderPlatform.ios.name
        : HeaderPlatform.unknown.name;

    super.onRequest(options, handler);
  }
}
