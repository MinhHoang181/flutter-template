import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:template/app/app.dart';

abstract interface class AuthStorage {
  Future<void> clearAll();

  Future<bool> saveRefreshToken(String value);

  Future<String?> getRefreshToken();

  Future<bool> removeRefreshToken();
}

@LazySingleton(as: AuthStorage)
class AuthStoreImp implements AuthStorage {
  AuthStoreImp({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  final FlutterSecureStorage _secureStorage;

  static const String _refreshTokenKey = 'refresh_token';

  @override
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }

  @override
  Future<bool> saveRefreshToken(String value) async {
    try {
      await _secureStorage.write(key: _refreshTokenKey, value: value);
      return true;
    } catch (error, stackTrace) {
      App.logError(
        title: '$AuthStorage.saveRefreshToken',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return _secureStorage.read(key: _refreshTokenKey);
    } catch (error, stackTrace) {
      App.logError(
        title: '$AuthStorage.getRefreshToken',
        error: error,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<bool> removeRefreshToken() async {
    try {
      await _secureStorage.delete(key: _refreshTokenKey);
      return true;
    } catch (error, stackTrace) {
      App.logError(
        title: '$AuthStorage.removeRefreshToken',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  }
}
