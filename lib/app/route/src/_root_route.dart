part of '../route.dart';

@TypedStatefulShellRoute<RootRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [_homeRoute]),
  ],
)
class RootRoute extends AppStatefulShellRouteData {
  const RootRoute() : this._internal();

  factory RootRoute.custom({AppTransitionType transitionType = AppTransitionType.noTransition}) {
    return RootRoute._internal(transitionType: transitionType);
  }

  const RootRoute._internal({this.transitionType = AppTransitionType.noTransition});

  @override
  final AppTransitionType transitionType;

  @override
  List<AppRedirect> get redirects => [];

  static String get initialLocation => const HomeRoute().location;

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
    return RootScreen(navigationShell: navigationShell);
  }
}

extension RootRouteExtension on RootRoute {
  void go(BuildContext context) => context.go(RootRoute.initialLocation);
}
