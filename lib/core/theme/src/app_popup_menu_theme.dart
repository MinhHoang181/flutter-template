part of '../app_theme.dart';

class AppPopupMenuTheme extends PopupMenuThemeData {
  AppPopupMenuTheme({required ColorScheme colorScheme})
    : super(
        color: colorScheme.surface,
        shape: null,
        menuPadding: null,
        elevation: 8,
        shadowColor: colorScheme.shadow,
        surfaceTintColor: colorScheme.surface,
        textStyle: AppFonts.size14Medium,
        labelTextStyle: null,
        enableFeedback: null,
        mouseCursor: null,
        position: null,
        iconColor: null,
        iconSize: null,
      );
}
