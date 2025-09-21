part of '../app_theme.dart';

class AppDividerTheme extends DividerThemeData {
  AppDividerTheme({required ColorScheme colorScheme})
    : super(
        /// Màu sắc của divider
        color: colorScheme.onSurfaceVariant,

        /// Khoảng cách giữa các divider
        space: null,

        /// Độ dày của divider
        thickness: 1,

        /// Khoảng cách từ lề trái của divider
        indent: null,

        /// Khoảng cách từ lề phải của divider
        endIndent: null,
      );
}
