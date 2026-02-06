import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/app/services/auth/auth_service.dart';
import 'package:template/app/services/auth/datasources/auth_client.dart';
import 'package:template/app/services/auth/datasources/auth_storage.dart';
import 'package:template/app/services/auth/models/auth_request.dart';
import 'package:template/app/services/auth/models/auth_response.dart';
import 'package:template/app/services/auth/models/jwt_token.dart';

class MockAuthStorage extends Mock implements AuthStorage {}
class MockAuthClient extends Mock implements AuthClient {}

void main() {
  late AuthService authService;
  late MockAuthStorage mockAuthStorage;
  late MockAuthClient mockAuthClient;

  String createFakeJwt({DateTime? expiration}) {
    final payload = {
      if (expiration != null) 'exp': expiration.millisecondsSinceEpoch ~/ 1000,
      'sub': '1234567890',
      'name': 'John Doe',
      'iat': 1516239022,
    };
    final payloadBase64 = base64Url.encode(utf8.encode(jsonEncode(payload))).replaceAll('=', '');
    return 'header.$payloadBase64.signature';
  }

  setUpAll(() {
    registerFallbackValue(const AuthRequest.refresh(refreshToken: ''));
  });

  setUp(() {
    mockAuthStorage = MockAuthStorage();
    mockAuthClient = MockAuthClient();
    authService = AuthService(
      authStorage: mockAuthStorage,
      authClient: mockAuthClient,
    );
  });

  group('AuthService', () {
    test('initial status is unauthorized', () {
      expect(authService.status, AuthStatus.unauthorized);
    });

    test('initialize loads access token and updates status to authorized if token is valid', () async {
      final token = createFakeJwt(expiration: DateTime.now().add(const Duration(hours: 1)));

      when(() => mockAuthStorage.getRefreshToken()).thenAnswer((_) async => 'refresh_token');
      when(() => mockAuthClient.authenticate(any())).thenAnswer((_) async => AuthResponse(
        accessToken: JwtToken(token),
        refreshToken: 'new_refresh_token',
      ));
      when(() => mockAuthStorage.saveRefreshToken(any())).thenAnswer((_) async => true);

      final status = await authService.initialize();

      expect(status, AuthStatus.authorized);
      expect(authService.accessToken?.value, token);
      expect(authService.status, AuthStatus.authorized);
      verify(() => mockAuthStorage.getRefreshToken()).called(1);
    });

    test('initialize remains unauthorized if no refresh token is found', () async {
      when(() => mockAuthStorage.getRefreshToken()).thenAnswer((_) async => null);

      final status = await authService.initialize();

      expect(status, AuthStatus.unauthorized);
      expect(authService.status, AuthStatus.unauthorized);
    });

    test('authenticate updates status and saves tokens', () async {
      final token = createFakeJwt(expiration: DateTime.now().add(const Duration(hours: 1)));
      final request = const AuthRequest.phone(phone: '123456', password: 'password');
      final response = AuthResponse(
        accessToken: JwtToken(token),
        refreshToken: 'refresh_token',
      );

      when(() => mockAuthClient.authenticate(request)).thenAnswer((_) async => response);
      when(() => mockAuthStorage.saveRefreshToken('refresh_token')).thenAnswer((_) async => true);

      final result = await authService.authenticate(request);

      expect(result, response);
      expect(authService.status, AuthStatus.authorized);
      expect(authService.accessToken?.value, token);
      verify(() => mockAuthStorage.saveRefreshToken('refresh_token')).called(1);
    });

    test('refreshToken deduplicates concurrent calls', () async {
      final token = createFakeJwt(expiration: DateTime.now().add(const Duration(hours: 1)));
      final response = AuthResponse(
        accessToken: JwtToken(token),
        refreshToken: 'new_refresh_token',
      );

      when(() => mockAuthStorage.getRefreshToken()).thenAnswer((_) async => 'refresh_token');
      when(() => mockAuthClient.authenticate(any())).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 100));
        return response;
      });
      when(() => mockAuthStorage.saveRefreshToken(any())).thenAnswer((_) async => true);

      final results = await Future.wait([
        authService.refreshToken(),
        authService.refreshToken(),
      ]);

      expect(results[0], response);
      expect(results[1], response);
      verify(() => mockAuthClient.authenticate(any())).called(1);
    });

    test('deauthenticate clears tokens and updates status', () async {
      final token = createFakeJwt(expiration: DateTime.now().add(const Duration(hours: 1)));
      when(() => mockAuthClient.authenticate(any())).thenAnswer((_) async => AuthResponse(
        accessToken: JwtToken(token),
        refreshToken: 'refresh_token',
      ));
      when(() => mockAuthStorage.saveRefreshToken(any())).thenAnswer((_) async => true);
      await authService.authenticate(const AuthRequest.phone(phone: '1', password: '1'));

      expect(authService.status, AuthStatus.authorized);

      when(() => mockAuthStorage.removeRefreshToken()).thenAnswer((_) async => true);

      await authService.deauthenticate(removeRefreshToken: true);

      expect(authService.status, AuthStatus.unauthorized);
      expect(authService.accessToken, null);
      verify(() => mockAuthStorage.removeRefreshToken()).called(1);
    });
  });
}
