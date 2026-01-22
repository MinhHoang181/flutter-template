import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../redirect/app_redirect.dart';
import 'app_transition_page.dart';

abstract class AppStatefulShellRouteData extends StatefulShellRouteData {
  const AppStatefulShellRouteData();

  List<AppRedirect> get redirects => [];

  AppTransitionType get transitionType => AppTransitionType.noTransition;

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  );

  @override
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppTransitionPage(
      key: state.pageKey,
      name: state.name,
      type: transitionType,
      child: builder(context, state, navigationShell),
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    for (final redirect in redirects) {
      final location = redirect.redirect(context, state);
      if (location != null) return location;
    }

    return null;
  }
}
