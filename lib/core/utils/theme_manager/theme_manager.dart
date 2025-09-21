import 'package:flutter/material.dart';
import 'package:template/core/utils/theme_manager/theme_manager_controller.dart';

class ThemeManager extends StatefulWidget {
  const ThemeManager({
    super.key,
    required this.child,
    this.supportedModes = const [ThemeMode.light],
    this.lightTheme,
    this.darkTheme,
  });

  final Widget child;

  final List<ThemeMode> supportedModes;

  final ThemeData? lightTheme;

  final ThemeData? darkTheme;

  @override
  State<ThemeManager> createState() => _ThemeManagerState();

  static _ThemeManagerScope of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ThemeManagerScope>()!;

  static Future<void> ensureInitialized() async => ThemeManagerController.initialize();
}

class _ThemeManagerState extends State<ThemeManager> {
  late final ThemeManagerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ThemeManagerController(
      supportedModes: widget.supportedModes,
      lightTheme: widget.lightTheme,
      darkTheme: widget.darkTheme,
    );
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ThemeManagerScope(controller: _controller, child: widget.child);
  }
}

class _ThemeManagerScope extends InheritedWidget {
  const _ThemeManagerScope({required this.controller, required super.child});

  final ThemeManagerController controller;

  ThemeMode get mode => controller.mode;

  @override
  bool updateShouldNotify(_ThemeManagerScope oldWidget) {
    return mode != oldWidget.mode;
  }
}
