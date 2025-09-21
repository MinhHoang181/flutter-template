part of '../app_theme.dart';

class AppColorScheme {
  const AppColorScheme._();

  static final ColorScheme light = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: AppColors.primary,

    // Primary colors
    primary: AppColors.primary,
    onPrimary: null,
    primaryContainer: null,
    onPrimaryContainer: null,

    // Secondary colors
    secondary: AppColors.secondary,
    onSecondary: null,
    secondaryContainer: null,
    onSecondaryContainer: null,

    // Tertiary colors
    tertiary: AppColors.tertiary,
    onTertiary: null,
    tertiaryContainer: null,
    onTertiaryContainer: null,

    // Error colors
    error: AppColors.error,
    onError: null,
    errorContainer: null,
    onErrorContainer: null,

    // Surface colors
    surface: null,
    onSurface: null,
    onSurfaceVariant: null,

    // Outline colors
    outline: null,
    outlineVariant: null,

    // Shadow and scrim
    shadow: null,
    scrim: null,

    // Inverse colors
    inverseSurface: null,
    onInverseSurface: null,
    inversePrimary: null,

    // Surface tint
    surfaceTint: null,

    // Fixed colors (Material 3)
    primaryFixed: null,
    onPrimaryFixed: null,
    primaryFixedDim: null,
    onPrimaryFixedVariant: null,

    secondaryFixed: null,
    onSecondaryFixed: null,
    secondaryFixedDim: null,
    onSecondaryFixedVariant: null,

    tertiaryFixed: null,
    onTertiaryFixed: null,
    tertiaryFixedDim: null,
    onTertiaryFixedVariant: null,

    // Surface container colors (Material 3)
    surfaceDim: null,
    surfaceBright: null,
    surfaceContainerLowest: null,
    surfaceContainerLow: null,
    surfaceContainer: null,
    surfaceContainerHigh: null,
    surfaceContainerHighest: null,
  );

  static final ColorScheme dark = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: AppColors.primary,

    // Primary colors
    primary: AppColors.primary,
    onPrimary: null,
    primaryContainer: null,
    onPrimaryContainer: null,

    // Secondary colors
    secondary: AppColors.secondary,
    onSecondary: null,
    secondaryContainer: null,
    onSecondaryContainer: null,

    // Tertiary colors
    tertiary: AppColors.tertiary,
    onTertiary: null,
    tertiaryContainer: null,
    onTertiaryContainer: null,

    // Error colors
    error: AppColors.error,
    onError: null,
    errorContainer: null,
    onErrorContainer: null,

    // Surface colors
    surface: null,
    onSurface: null,
    onSurfaceVariant: null,

    // Outline colors
    outline: null,
    outlineVariant: null,

    // Shadow and scrim
    shadow: null,
    scrim: null,

    // Inverse colors
    inverseSurface: null,
    onInverseSurface: null,
    inversePrimary: null,

    // Surface tint
    surfaceTint: null,

    // Fixed colors (Material 3)
    primaryFixed: null,
    onPrimaryFixed: null,
    primaryFixedDim: null,
    onPrimaryFixedVariant: null,

    secondaryFixed: null,
    onSecondaryFixed: null,
    secondaryFixedDim: null,
    onSecondaryFixedVariant: null,

    tertiaryFixed: null,
    onTertiaryFixed: null,
    tertiaryFixedDim: null,
    onTertiaryFixedVariant: null,

    // Surface container colors (Material 3)
    surfaceDim: null,
    surfaceBright: null,
    surfaceContainerLowest: null,
    surfaceContainerLow: null,
    surfaceContainer: null,
    surfaceContainerHigh: null,
    surfaceContainerHighest: null,
  );
}

extension ColorSchemeBuildContextExt on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}
