import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app.dart';
import '../route.dart';
import 'app_redirect.dart';

class SplashRedirect extends AppRedirect {
  const SplashRedirect();

  @override
  String? redirect(BuildContext context, GoRouterState state) {
    final bool isSplashRoute = isRoute(state, const SplashRoute().location);

    if (isSplashRoute) {
      return null;
    }

    if (initializeAppCompleter.isCompleted) {
      return null;
    }

    return const SplashRoute().location;
  }
}
