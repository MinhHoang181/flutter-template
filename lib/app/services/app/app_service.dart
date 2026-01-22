import 'package:injectable/injectable.dart';

import '../../app.dart';
import 'app_storage.dart';

@Singleton()
class AppService {
  AppService({required AppStorage appStorage}) : _appStorage = appStorage;

  final AppStorage _appStorage;

  Future<void> initialize() async {
    try {
      _isStartAppFirstTime = _appStorage.isFirsTimeStartApp();
    } catch (error, stackTrace) {
      App.logError(
        title: '$AppService.initialize',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  bool _isStartAppFirstTime = false;
  bool get isStartAppFirstTime => _isStartAppFirstTime;
}
