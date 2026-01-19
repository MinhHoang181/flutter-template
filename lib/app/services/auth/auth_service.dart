import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:template/app/app.dart';
import 'package:template/app/mediator/mediator.dart';
import 'package:template/core/utils/async_deduplicator.dart';

import 'datasources/auth_client.dart';
import 'datasources/auth_storage.dart';
import 'models/auth_exception.dart';
import 'models/auth_request.dart';
import 'models/auth_response.dart';
import 'models/jwt_token.dart';

enum AuthStatus { authorized, unauthorized }

@Singleton()
class AuthService {
  AuthService({
    required AuthStorage authStorage,
    required AuthClient authClient,
  }) : _authStorage = authStorage,
       _authClient = authClient;

  final AuthStorage _authStorage;

  final AuthClient _authClient;

  AuthStatus _status = AuthStatus.unauthorized;

  final StreamController<AuthStatus> _statusController =
      StreamController<AuthStatus>.broadcast();

  AuthStatus get status => _status;

  Stream<AuthStatus> get statusStream =>
      _statusController.stream.startWith(_status);

  JwtToken? _accessToken;
  JwtToken? get accessToken => _accessToken;

  String? _refreshToken;

  final AsyncDeduplicator<AuthResponse> _refreshTokenDeduplicator =
      AsyncDeduplicator();

  Future<AuthStatus> initialize() async {
    try {
      await getAccessToken();
    } catch (error, stackTrace) {
      App.logError(
        title: '$AuthService.initialize',
        error: error,
        stackTrace: stackTrace,
      );
    }

    return status;
  }

  Future<JwtToken?> getAccessToken() async {
    final JwtToken? accessToken = _accessToken;

    if (accessToken != null && accessToken.isValid) return accessToken;

    // try get new access token
    try {
      final response = await refreshToken();
      return response.accessToken;
    } catch (_) {
      _accessToken = null;
      _updateStatus(AuthStatus.unauthorized);
      return null;
    }
  }

  String? getRefreshToken() {
    return _refreshToken;
  }

  Future<AuthResponse> authenticate(AuthRequest request) async {
    final response = await _authClient.authenticate(request);

    if (!response.accessToken.isValid) {
      if (response.refreshToken.isNotEmpty) {
        return refreshToken(response.refreshToken);
      }
      _accessToken = null;
      _updateStatus(AuthStatus.unauthorized);
      throw const InvalidAccessTokenException();
    }

    _accessToken = response.accessToken;

    if (response.refreshToken.isNotEmpty) {
      _refreshToken = response.refreshToken;
      await _authStorage.saveRefreshToken(response.refreshToken);
    }

    _updateStatus(AuthStatus.authorized);

    return response;
  }

  Future<AuthResponse> refreshToken([String? token]) {
    return _refreshTokenDeduplicator.fetch(() async {
      String? refreshToken = token ?? _refreshToken;

      if (refreshToken == null) {
        final String? refreshTokenValue = await _authStorage.getRefreshToken();
        if (refreshTokenValue != null && refreshTokenValue.isNotEmpty) {
          refreshToken = refreshTokenValue;
        }
      }
      if (refreshToken == null) {
        _refreshToken = null;
        _updateStatus(AuthStatus.unauthorized);
        throw const EmptyRefreshTokenException();
      }
      if (refreshToken.isEmpty) {
        _refreshToken = null;
        await _authStorage.removeRefreshToken();
        _updateStatus(AuthStatus.unauthorized);
        throw const InvalidRefreshTokenException();
      }

      try {
        final response = await authenticate(
          AuthRequest.refresh(refreshToken: refreshToken),
        );

        await mediator.requests.send(
          RefreshTokenEvent(refreshToken: refreshToken, response: response),
        );

        return response;
      } on DioException catch (error) {
        if (error.response?.statusCode == HttpStatus.unauthorized) {
          _refreshToken = null;
          await _authStorage.removeRefreshToken();
          _updateStatus(AuthStatus.unauthorized);
        }
        rethrow;
      }
    });
  }

  Future<void> deauthenticate({bool removeRefreshToken = false}) async {
    if (_status == AuthStatus.unauthorized) return;

    if (removeRefreshToken) {
      await _authStorage.removeRefreshToken();
    }
    _accessToken = null;
    _refreshToken = null;
    _updateStatus(AuthStatus.unauthorized);
  }

  void _updateStatus(AuthStatus status) {
    if (_status == status) return;

    _status = status;
    _statusController.add(_status);
  }
}
