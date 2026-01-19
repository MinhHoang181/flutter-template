import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_request.freezed.dart';

@Freezed()
abstract class AuthRequest with _$AuthRequest {
  const factory AuthRequest.phone({
    required String phone,
    required String password,
  }) = _PhoneAuthRequest;

  const factory AuthRequest.email({
    required String email,
    required String password,
  }) = _EmailAuthRequest;

  const factory AuthRequest.refresh({required String refreshToken}) =
      _RefreshAuthRequest;
}
