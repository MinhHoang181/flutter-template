import 'package:injectable/injectable.dart';

import '../models/auth_request.dart';
import '../models/auth_response.dart';

abstract interface class AuthClient {
  Future<AuthResponse> authenticate(AuthRequest request);
}

@LazySingleton(as: AuthClient)
class AuthClientImpl implements AuthClient {
  AuthClientImpl();

  @override
  Future<AuthResponse> authenticate(AuthRequest request) {
    throw UnimplementedError();
  }
}
