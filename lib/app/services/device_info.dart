import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class DeviceInfo {
  DeviceInfo({required BaseDeviceInfo baseDeviceInfo}) : _baseDeviceInfo = baseDeviceInfo;

  final BaseDeviceInfo _baseDeviceInfo;

  /// Device name
  String get deviceName {
    String name = 'unknown';

    final BaseDeviceInfo deviceInfo = _baseDeviceInfo;

    if (deviceInfo is AndroidDeviceInfo) {
      name = deviceInfo.model;
    } else if (deviceInfo is IosDeviceInfo) {
      name = deviceInfo.name;
    }

    return name;
  }

  /// Device version
  String get deviceVersion {
    String version = 'unknown';

    final BaseDeviceInfo deviceInfo = _baseDeviceInfo;

    if (deviceInfo is AndroidDeviceInfo) {
      version = deviceInfo.version.release;
    } else if (deviceInfo is IosDeviceInfo) {
      version = deviceInfo.systemVersion;
    }

    return version;
  }

  /// Device ID
  String get deviceId {
    String id = 'unknown';

    final BaseDeviceInfo deviceInfo = _baseDeviceInfo;

    if (deviceInfo is AndroidDeviceInfo) {
      id = deviceInfo.id;
    } else if (deviceInfo is IosDeviceInfo) {
      id = deviceInfo.identifierForVendor ?? 'unknown';
    }

    return id;
  }
}
