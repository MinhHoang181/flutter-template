import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app/root/screens/navigation_error_screen.dart';
import 'package:template/app/root/screens/root_screen.dart';
import 'package:template/app/root/screens/splash_screen.dart';
import 'package:template/app/route/data/app_route_data.dart';
import 'package:template/app/route/data/app_router_observer.dart';
import 'package:template/app/route/data/app_stateful_shell_route_data.dart';
import 'package:template/app/route/data/app_transition_page.dart';
import 'package:template/app/route/redirect/app_redirect.dart';
import 'package:template/app/route/redirect/splash_redirect.dart';
import 'package:template/features/home/presentation/screens/home_screen.dart';

part 'route.g.dart';
part 'src/_root_route.dart';
part 'src/common_route.dart';

class AppRouter {
  factory AppRouter() => instance;

  AppRouter._() : super();

  static AppRouter? _instance;

  static AppRouter get instance {
    if (_instance == null) {
      _instance = AppRouter._();
      _instance!._initialize();
    }
    return _instance!;
  }

  late GoRouter _router;

  GoRouter get router => _router;

  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  void _initialize() {
    _router = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: RootRoute.initialLocation,
      observers: <NavigatorObserver>[AppRouterObserver()].toList(),
      errorPageBuilder: (context, state) {
        return AppTransitionPage(
          key: state.pageKey,
          name: state.name,
          type: AppTransitionType.noTransition,
          child: NavigationErrorScreen(
            error: state.error?.toString(),
            onBackHome: (context) => const RootRoute().go(context),
          ),
        );
      },
      redirect: (context, state) {
        final String? location = AppRedirect.check(context, state, list: [const SplashRedirect()]);

        return location;
      },
      routes: $appRoutes,
    );
  }
}

class RedirectData {
  RedirectData({required this.from, this.extra});

  final String from;

  final Object? extra;
}
