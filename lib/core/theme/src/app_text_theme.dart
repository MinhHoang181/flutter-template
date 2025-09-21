part of '../app_theme.dart';

AppTextTheme appTextTheme = AppTextTheme._();

class AppTextTheme extends TextTheme {
  AppTextTheme._()
    : super(
        // Display styles (rất to, dùng cho landing / hero section / số liệu lớn)
        displayLarge: _withFamily(AppFonts.size32Bold), // ~H1
        displayMedium: _withFamily(AppFonts.size28Semi), // ~H2
        displaySmall: _withFamily(AppFonts.size24Medium), // ~H3
        // Headline styles (dùng cho screen title, section title)
        headlineLarge: _withFamily(AppFonts.size22Bold),
        headlineMedium: _withFamily(AppFonts.size20Semi),
        headlineSmall: _withFamily(AppFonts.size18Medium),
        // Title styles (dùng cho app bar title, card title, dialog title, subtitle)
        titleLarge: _withFamily(AppFonts.size18Semi),
        titleMedium: _withFamily(AppFonts.size16Medium),
        titleSmall: _withFamily(AppFonts.size14Medium),
        // Body styles (content text, paragraph, helper text)
        bodyLarge: _withFamily(AppFonts.size16Regular),
        bodyMedium: _withFamily(AppFonts.size14Regular),
        bodySmall: _withFamily(AppFonts.size12Regular),
        // Label styles (button text, chips, tag)
        labelLarge: _withFamily(AppFonts.size14Medium),
        labelMedium: _withFamily(AppFonts.size12Medium),
        labelSmall: _withFamily(AppFonts.size11Regular),
      );

  static TextStyle _withFamily(TextStyle style) => style.copyWith(fontFamily: AppFonts.fontFamily);

  // Display styles
  @override
  TextStyle get displayLarge => super.displayLarge!;
  @override
  TextStyle get displayMedium => super.displayMedium!;
  @override
  TextStyle get displaySmall => super.displaySmall!;

  // Headline styles
  @override
  TextStyle get headlineLarge => super.headlineLarge!;
  @override
  TextStyle get headlineMedium => super.headlineMedium!;
  @override
  TextStyle get headlineSmall => super.headlineSmall!;

  // Title styles
  @override
  TextStyle get titleLarge => super.titleLarge!;
  @override
  TextStyle get titleMedium => super.titleMedium!;
  @override
  TextStyle get titleSmall => super.titleSmall!;

  // Body styles
  @override
  TextStyle get bodyLarge => super.bodyLarge!;
  @override
  TextStyle get bodyMedium => super.bodyMedium!;
  @override
  TextStyle get bodySmall => super.bodySmall!;

  // Label styles
  @override
  TextStyle get labelLarge => super.labelLarge!;
  @override
  TextStyle get labelMedium => super.labelMedium!;
  @override
  TextStyle get labelSmall => super.labelSmall!;
}

extension TextThemeBuildContextExt on BuildContext {
  AppTextTheme get textTheme {
    final textTheme = Theme.of(this).textTheme;

    if (textTheme is AppTextTheme) {
      return textTheme;
    }

    return appTextTheme;
  }
}
