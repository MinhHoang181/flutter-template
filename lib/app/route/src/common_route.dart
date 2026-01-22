part of '../route.dart';

const TypedGoRoute _homeRoute = TypedGoRoute<HomeRoute>(path: '/');

class HomeRoute extends AppRouteData with $HomeRoute, AppRouteDataMixin {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeScreen();
  }
}

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends AppRouteData with $SplashRoute, AppRouteDataMixin {
  const SplashRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      AppRouter.instance.rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}
