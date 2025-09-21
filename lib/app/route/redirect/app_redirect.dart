import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRedirect {
  const AppRedirect();

  String? redirect(BuildContext context, GoRouterState state);

  bool isRoute(GoRouterState state, String url) {
    final stateUri = state.uri.toString();

    final statePath = stateUri.split('?').first;
    final urlPath = url.split('?').first;

    if (statePath == urlPath) return true;

    return statePath.startsWith(urlPath);
  }

  static String? _location;

  static String? check(
    BuildContext context,
    GoRouterState state, {
    required List<AppRedirect> list,
  }) {
    if (_location == state.uri.toString()) return null;

    for (final appRedirect in list) {
      final location = appRedirect.redirect(context, state);
      if (location != null) return location;
    }

    return null;
  }
}
