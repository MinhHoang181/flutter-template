import 'package:flutter/material.dart';
import 'package:template/core/utils/theme_manager/theme_manager.dart';
import 'package:template/core/utils/theme_manager/theme_manager_controller.dart';

extension ThemeManagerContextExt on BuildContext {
  ThemeManagerController get _controller => ThemeManager.of(this).controller;

  ThemeMode get themeMode => _controller.mode;

  ThemeData? get lightTheme => _controller.lightTheme;

  ThemeData? get darkTheme => _controller.darkTheme;

  Future<void> setThemeMode(ThemeMode mode) => _controller.setMode(mode);

  Future<void> clearSavedThemeMode() => _controller.clearSavedMode();
}
