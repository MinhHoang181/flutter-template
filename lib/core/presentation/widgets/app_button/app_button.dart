import 'package:flutter/material.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_spacing.dart';
import 'package:template/core/theme/app_theme.dart';

import '../app_icon.dart';
import '../app_text.dart';

part 'src/app_filled_button.dart';
part 'src/app_outline_button.dart';
part 'src/app_text_button.dart';
part 'src/app_icon_button.dart';

enum AppButtonSize { extraSmall, small, medium, large, extraLarge }

abstract class AppButton extends StatelessWidget {
  const AppButton._({
    super.key,
    required this.onPressed,
    this.onLongPress,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.minimumSize,
    this.maximumSize,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
    this.visualDensity,
  });

  const factory AppButton.filled({
    Key? key,
    required String label,
    Object? icon,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    AppFilledButtonStyle style,
    AppButtonSize size,
    IconAlignment iconAlignment,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    double? iconSize,
    Size? minimumSize,
    Size? maximumSize,
    Color? backgroundColor,
    Color? foregroundColor,
    OutlinedBorder? shape,
    VisualDensity? visualDensity,
  }) = AppFilledButton;

  const factory AppButton.outlined({
    Key? key,
    required String label,
    Object? icon,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    AppButtonSize size,
    IconAlignment iconAlignment,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    double? iconSize,
    Size? minimumSize,
    Size? maximumSize,
    Color? backgroundColor,
    Color? foregroundColor,
    OutlinedBorder? shape,
    VisualDensity? visualDensity,
  }) = AppOutlineButton;

  const factory AppButton.text({
    Key? key,
    required String label,
    Object? icon,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    AppButtonSize size,
    IconAlignment iconAlignment,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
    double? iconSize,
    Size? minimumSize,
    Size? maximumSize,
    Color? backgroundColor,
    Color? foregroundColor,
    OutlinedBorder? shape,
    VisualDensity? visualDensity,
  }) = AppTextButton;

  const factory AppButton.icon({
    Key? key,
    required Object icon,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    AppIconButtonStyle style,
    AppButtonSize size,
    EdgeInsetsGeometry? padding,
    double? iconSize,
    Size? minimumSize,
    Size? maximumSize,
    Color? backgroundColor,
    Color? foregroundColor,
    OutlinedBorder? shape,
    VisualDensity? visualDensity,
    String? tooltip,
  }) = AppIconButton;

  final AppButtonSize size;

  final Object? icon;

  final IconAlignment iconAlignment;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final EdgeInsetsGeometry? padding;

  final TextStyle? textStyle;

  final double? iconSize;

  final Size? minimumSize;

  final Size? maximumSize;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final OutlinedBorder? shape;

  final VisualDensity? visualDensity;

  EdgeInsetsGeometry get _padding {
    if (padding != null) return padding!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.s2,
          vertical: AppSpacing.s1,
        );
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.s3,
          vertical: AppSpacing.s2,
        );
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.s5,
          vertical: AppSpacing.s3,
        );
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.s5,
          vertical: AppSpacing.s3,
        );
      case AppButtonSize.extraLarge:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.s5,
          vertical: AppSpacing.s3,
        );
    }
  }

  TextStyle? get _textStyle {
    if (textStyle != null) return textStyle!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return AppFonts.size12Medium;
      case AppButtonSize.small:
        return AppFonts.size14Medium;
      case AppButtonSize.medium:
        return AppFonts.size14Semi;
      case AppButtonSize.large:
        return AppFonts.size16Semi;
      case AppButtonSize.extraLarge:
        return AppFonts.size18Semi;
    }
  }

  double? get _iconSize {
    if (iconSize != null) return iconSize!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return 16;
      case AppButtonSize.small:
        return 18;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
      case AppButtonSize.extraLarge:
        return 28;
    }
  }

  Size? get _minimumSize {
    if (minimumSize != null) return minimumSize!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return const Size(56, 28);
      case AppButtonSize.small:
        return const Size(60, 32);
      case AppButtonSize.medium:
        return const Size(80, 40);
      case AppButtonSize.large:
        return const Size(96, 56);
      case AppButtonSize.extraLarge:
        return const Size(112, 56);
    }
  }

  Size? get _maximumSize {
    if (maximumSize != null) return maximumSize!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return Size(120, 28 + _padding.vertical);
      case AppButtonSize.small:
        return Size(160, 32 + _padding.vertical);
      case AppButtonSize.medium:
        return Size(200, 40 + _padding.vertical);
      case AppButtonSize.large:
        return Size(240, 48 + _padding.vertical);
      case AppButtonSize.extraLarge:
        return Size(320, 56 + _padding.vertical);
    }
  }

  VisualDensity? get _visualDensity {
    if (visualDensity != null) return visualDensity!;

    return switch (size) {
      AppButtonSize.extraSmall => const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      AppButtonSize.small => VisualDensity.compact,
      AppButtonSize.medium => VisualDensity.comfortable,
      AppButtonSize.large => VisualDensity.standard,
      AppButtonSize.extraLarge => const VisualDensity(
        horizontal: VisualDensity.maximumDensity,
        vertical: VisualDensity.maximumDensity,
      ),
    };
  }

  @override
  Widget build(BuildContext context);
}
