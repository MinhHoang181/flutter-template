import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:template/app/services/auth/models/jwt_token.dart';

void main() {
  String createFakeJwt({Map<String, dynamic>? payload}) {
    final header = base64Url.encode(utf8.encode(jsonEncode({'alg': 'HS256', 'typ': 'JWT'}))).replaceAll('=', '');
    final payloadStr = base64Url.encode(utf8.encode(jsonEncode(payload ?? {}))).replaceAll('=', '');
    return '$header.$payloadStr.signature';
  }

  group('JwtToken', () {
    test('authorizationValue should return Bearer token', () {
      const token = JwtToken('abc.def.ghi');
      expect(token.authorizationValue, 'Bearer abc.def.ghi');
    });

    test('isValid should return true for non-expired token', () {
      final exp = DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000;
      final jwt = createFakeJwt(payload: {'exp': exp});
      final token = JwtToken(jwt);
      expect(token.isValid, true);
    });

    test('isValid should return false for expired token', () {
      final exp = DateTime.now().subtract(const Duration(hours: 1)).millisecondsSinceEpoch ~/ 1000;
      final jwt = createFakeJwt(payload: {'exp': exp});
      final token = JwtToken(jwt);
      expect(token.isValid, false);
    });

    test('payload should return decoded map', () {
      final jwt = createFakeJwt(payload: {'sub': '123', 'name': 'John'});
      final token = JwtToken(jwt);
      expect(token.payload?['sub'], '123');
      expect(token.payload?['name'], 'John');
    });

    test('expiration should return correct DateTime', () {
      final nowSeconds = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final jwt = createFakeJwt(payload: {'exp': nowSeconds});
      final token = JwtToken(jwt);
      expect(token.expiration?.millisecondsSinceEpoch != null, true);
      expect(token.expiration!.millisecondsSinceEpoch ~/ 1000, nowSeconds);
    });
  });

  group('JwtDecoder', () {
    test('decode should throw FormatException for invalid token', () {
      expect(() => JwtDecoder.decode('invalid'), throwsFormatException);
    });

    test('tryDecode should return null for invalid token', () {
      expect(JwtDecoder.tryDecode('invalid'), isNull);
    });
  });
}
