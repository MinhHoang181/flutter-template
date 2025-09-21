import 'package:flutter/material.dart';
import 'package:template/core/theme/app_colors.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_radius.dart';
import 'package:template/core/theme/app_spacing.dart';

part 'src/app_color_scheme.dart';
part 'src/app_text_theme.dart';
part 'src/app_app_bar_theme.dart';
part 'src/app_tab_bar_theme.dart';
part 'src/app_button_theme.dart';
part 'src/app_divider_theme.dart';
part 'src/app_input_decoration_theme.dart';

final class AppTheme {
  static final ThemeData light = _base(colorScheme: AppColorScheme.light);

  static final ThemeData dark = _base(colorScheme: AppColorScheme.dark);

  static ThemeData _base({required ColorScheme colorScheme}) {
    final AppTextTheme textTheme = appTextTheme;

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: AppFonts.fontFamily,
      visualDensity: VisualDensity.standard,
      textTheme: textTheme,
      appBarTheme: AppAppBarTheme(colorScheme: colorScheme, textTheme: textTheme),
      tabBarTheme: AppTabBarTheme(colorScheme: colorScheme, textTheme: textTheme),
      buttonTheme: AppButtonTheme(colorScheme: colorScheme),
      dividerTheme: AppDividerTheme(colorScheme: colorScheme),
      inputDecorationTheme: AppInputDecorationTheme(colorScheme: colorScheme, textTheme: textTheme),
    );
  }
}
