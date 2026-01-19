import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as env;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/gen/assets.gen.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();

  @preResolve
  Future<BaseDeviceInfo> get deviceInfo => DeviceInfoPlugin().deviceInfo;

  @preResolve
  Future<env.DotEnv> get dotenv async {
    await env.dotenv.load(fileName: Assets.aEnv);
    return env.dotenv;
  }

  FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
    aOptions: AndroidOptions.defaultOptions,
    iOptions: IOSOptions.defaultOptions,
  );
}
