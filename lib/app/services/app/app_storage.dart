import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/app/app.dart';

abstract interface class AppStorage {
  Future<bool> startAppFirstTime();

  bool isFirsTimeStartApp();
}

@LazySingleton(as: AppStorage)
final class AppStorageImpl implements AppStorage {
  AppStorageImpl({required SharedPreferences prefs}) : _prefs = prefs;

  static const String _firstTimeStartAppKey = 'first_time_start_app';

  final SharedPreferences _prefs;

  @override
  bool isFirsTimeStartApp() {
    try {
      final bool isFirstTimeStartApp =
          _prefs.getBool(_firstTimeStartAppKey) ?? true;

      if (isFirstTimeStartApp) {
        startAppFirstTime();
      }

      return isFirstTimeStartApp;
    } catch (error, stackTrace) {
      App.logError(
        title: '$AppStorageImpl.isFirsTimeStartApp',
        error: error,
        stackTrace: stackTrace,
      );
      return true;
    }
  }

  @override
  Future<bool> startAppFirstTime() async {
    try {
      return _prefs.setBool(_firstTimeStartAppKey, false);
    } catch (error, stackTrace) {
      App.logError(
        title: '$AppStorageImpl.startAppFirstTime',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
