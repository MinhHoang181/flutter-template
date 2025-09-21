import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppStorage implements FirstTimeStartAppStorage {}

abstract interface class FirstTimeStartAppStorage {
  static const String _firstTimeStartAppKey = 'first_time_start_app';

  Future<bool> startAppFirstTime();

  bool isFirsTimeStartApp();
}

@LazySingleton(as: AppStorage)
final class AppStorageImpl implements AppStorage {
  AppStorageImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  bool isFirsTimeStartApp() {
    final bool isFirstTimeStartApp = _prefs.getBool(FirstTimeStartAppStorage._firstTimeStartAppKey) ?? true;

    if (isFirstTimeStartApp) {
      startAppFirstTime();
    }

    return isFirstTimeStartApp;
  }

  @override
  Future<bool> startAppFirstTime() {
    return _prefs.setBool(FirstTimeStartAppStorage._firstTimeStartAppKey, false);
  }
}
