import 'package:freezed_annotation/freezed_annotation.dart';
import 'jwt_token.dart';

part 'auth_response.freezed.dart';

@Freezed()
class AuthResponse with _$AuthResponse {
  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    this.data,
  });

  @override
  final JwtToken accessToken;

  @override
  final String refreshToken;

  @override
  final Object? data;
}
