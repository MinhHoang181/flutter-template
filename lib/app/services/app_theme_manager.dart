import 'package:flutter/material.dart';
import 'package:template/core/theme/app_theme.dart';
import 'package:template/core/utils/theme_manager/theme_manager.dart';

export 'package:template/core/utils/theme_manager/theme_manager_extension.dart' show ThemeManagerContextExt;

class AppThemeManager extends StatelessWidget {
  const AppThemeManager({super.key, required this.child});

  final Widget child;

  static Future<void> ensureInitialized() async {
    await ThemeManager.ensureInitialized();
  }

  static List<ThemeMode> get supportedModes => const [ThemeMode.light];

  @override
  Widget build(BuildContext context) {
    return ThemeManager(
      supportedModes: supportedModes,
      lightTheme: AppTheme.light,
      darkTheme: AppTheme.dark,
      child: child,
    );
  }
}
