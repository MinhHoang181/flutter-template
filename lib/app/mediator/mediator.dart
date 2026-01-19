import 'dart:async';

import 'package:dart_mediator/mediator.dart';

import '../app.dart';
import '../route/route.dart';
import '../services/auth/models/auth_request.dart';
import '../services/auth/models/auth_response.dart';

part 'events/authenticate_event.dart';
part 'events/unauthorized_event.dart';

final mediator = Mediator.create();

void configureMediator() {
  // login
  mediator.requests.register(_ManualLoginHandler());
  mediator.requests.register(_RefreshTokenHandler());

  // unauthorized
  mediator.requests.register(_ManualLogoutHandler());
  mediator.requests.register(_PreManualLogoutHandler());
  mediator.requests.register(_UnauthorizedTokenHandler());
}
