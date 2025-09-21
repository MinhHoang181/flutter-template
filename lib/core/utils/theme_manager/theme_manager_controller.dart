import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManagerController extends ChangeNotifier {
  ThemeManagerController({
    this.supportedModes = const [ThemeMode.light],
    required this.lightTheme,
    required this.darkTheme,
  }) {
    _mode = _savedMode ?? supportedModes.first;
  }

  static const String _themeKey = 'app_theme_mode';

  static ThemeMode? _savedMode;

  static Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString != null) {
      _savedMode = ThemeMode.values.firstWhere((mode) => mode.name == themeString, orElse: () => ThemeMode.light);
    }
  }

  late ThemeMode _mode;
  ThemeMode get mode => _mode;

  final List<ThemeMode> supportedModes;

  final ThemeData? lightTheme;

  final ThemeData? darkTheme;

  Future<void> setMode(ThemeMode mode) async {
    if (_mode == mode) return;
    if (!supportedModes.contains(mode)) return;

    _mode = mode;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, mode.name);
  }

  Future<void> clearSavedMode() async {
    _savedMode = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_themeKey);
  }
}
