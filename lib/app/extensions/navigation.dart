part of '../app.dart';

extension NavigatorExt on _AppExt {
  GlobalKey<NavigatorState> get rootNavigatorKey => AppRouter.instance.rootNavigatorKey;

  GoRouter get router => AppRouter.instance.router;

  // context of root navigator
  BuildContext get context => rootNavigatorKey.currentContext!;

  void go(String location, {Object? extra}) => router.go(location, extra: extra);

  void pop<T>([T? result]) => router.pop(result);

  Future<T?> push<T>(String location, {Object? extra}) => router.push<T>(location);

  Future<T?> pushCustom<T>(Widget Function(BuildContext context) builder) =>
      Navigator.of(context).push<T>(MaterialPageRoute(builder: builder));
}
