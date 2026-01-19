import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<RootScreen> createState() => RootScreenState();

  static RootScreenState? maybeOf(BuildContext context) {
    final _RootScope? scope = context.dependOnInheritedWidgetOfExactType<_RootScope>();

    return scope?._rootState;
  }
}

class RootScreenState extends State<RootScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return _RootScope(
      rootState: this,
      navigationShell: widget.navigationShell,
      child: Scaffold(key: scaffoldKey, resizeToAvoidBottomInset: false, body: widget.navigationShell),
    );
  }
}

class _RootScope extends InheritedWidget {
  const _RootScope({
    required super.child,
    required StatefulNavigationShell navigationShell,
    required RootScreenState rootState,
  }) : _rootState = rootState;

  final RootScreenState _rootState;

  @override
  bool updateShouldNotify(covariant _RootScope oldWidget) => false; // only for get state
}
