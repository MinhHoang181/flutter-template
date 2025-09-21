import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@Singleton()
class AppInfo {
  AppInfo({required PackageInfo packageInfo}) : _packageInfo = packageInfo;

  final PackageInfo _packageInfo;

  /// App name
  String get appName {
    final String name = _packageInfo.appName;

    return name;
  }

  /// App version
  String version({bool showBuildNumber = false}) {
    String version = versionNumber;

    if (showBuildNumber) {
      version = '$version($buildNumber)';
    }

    return version;
  }

  /// Version number
  String get versionNumber {
    final String versionNumber = _packageInfo.version;

    return versionNumber;
  }

  /// Build number
  String get buildNumber {
    String buildNumber = _packageInfo.buildNumber;

    if (Platform.isAndroid) {
      buildNumber = buildNumber.substring(buildNumber.length - 3);
      buildNumber = int.tryParse(buildNumber)?.toString() ?? buildNumber;
    }

    return buildNumber;
  }
}
