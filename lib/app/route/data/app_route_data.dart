import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app/route/data/app_transition_page.dart';
import 'package:template/app/route/redirect/app_redirect.dart';

abstract class AppRouteData implements GoRouteData {
  const AppRouteData();

  List<AppRedirect> get redirects => [];

  AppTransitionType get transitionType => AppTransitionType.rightToLeft;

  @override
  Widget build(BuildContext context, GoRouterState state);

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    if (transitionType == AppTransitionType.rightToLeft) {
      return CupertinoPage(key: state.pageKey, name: state.name, child: build(context, state));
    }

    return AppTransitionPage(key: state.pageKey, name: state.name, type: transitionType, child: build(context, state));
  }

  @override
  FutureOr<bool> onExit(BuildContext context, GoRouterState state) {
    return true;
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

// Need add last to override the mixin of auto generated code
mixin AppRouteDataMixin on AppRouteData {
  @override
  String get location;

  Object? get $extra => null;

  @override
  Future<T?> push<T>(BuildContext context) async {
    return context.push(location, extra: $extra);
  }

  @override
  void go(BuildContext context) {
    context.go(location, extra: $extra);
  }

  @override
  void pushReplacement(BuildContext context) {
    context.pushReplacement(location, extra: $extra);
  }

  @override
  void replace(BuildContext context) {
    context.replace(location, extra: $extra);
  }
}
