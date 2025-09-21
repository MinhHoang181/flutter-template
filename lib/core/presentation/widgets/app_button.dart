import 'package:flutter/material.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_radius.dart';
import 'package:template/core/theme/app_spacing.dart';

enum AppButtonStyle { filled, outlined, text, _icon }

enum AppButtonSize { extraSmall, small, medium, large, extraLarge }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.style = AppButtonStyle.filled,
    required String this.label,
    required this.onPressed,
    this.onLongPress,
    this.size = AppButtonSize.medium,
    this.icon,
    this.iconAlignment = IconAlignment.start,
    this.buttonStyle,
    this.padding,
    this.textStyle,
    this.iconSize,
    this.minimumSize,
    this.maximumSize,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
  });

  const AppButton.icon({
    super.key,
    required Widget this.icon,
    required this.onPressed,
    this.onLongPress,
    this.size = AppButtonSize.medium,
    this.buttonStyle,
    this.padding,
    this.iconSize,
    this.minimumSize,
    this.maximumSize,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
  }) : style = AppButtonStyle._icon,
       label = null,
       iconAlignment = IconAlignment.start,
       textStyle = null;

  final AppButtonStyle style;

  final AppButtonSize size;

  final Widget? icon;

  final IconAlignment iconAlignment;

  final String? label;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final EdgeInsetsGeometry? padding;

  final ButtonStyle? buttonStyle;

  final TextStyle? textStyle;

  final double? iconSize;

  final Size? minimumSize;

  final Size? maximumSize;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final OutlinedBorder? shape;

  ButtonStyle? _buttonStyle(BuildContext context) {
    if (buttonStyle != null) return buttonStyle!;

    switch (style) {
      case AppButtonStyle.filled:
        return FilledButton.styleFrom(
          backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
          foregroundColor: foregroundColor ?? Colors.white,
          padding: _padding,
          textStyle: _textStyle,
          iconSize: _iconSize,
          iconAlignment: iconAlignment,
          minimumSize: _minimumSize,
          maximumSize: _maximumSize,
          elevation: 0,
          shape: _shape,
        );
      case AppButtonStyle.outlined:
        return OutlinedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.white,
          foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
          padding: _padding,
          textStyle: _textStyle,
          iconSize: _iconSize,
          iconAlignment: iconAlignment,
          minimumSize: _minimumSize,
          maximumSize: _maximumSize,
          elevation: 0,
          shape: _shape,
        );
      case AppButtonStyle.text:
        return TextButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.transparent,
          foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.primary,
          padding: _padding,
          textStyle: _textStyle,
          iconSize: _iconSize,
          iconAlignment: iconAlignment,
          minimumSize: _minimumSize,
          maximumSize: _maximumSize,
          elevation: 0,
          shape: _shape,
        );
      case AppButtonStyle._icon:
        return IconButton.styleFrom(
          padding: _padding,
          iconSize: _iconSize,
          fixedSize: switch (size) {
            AppButtonSize.extraSmall => const Size.square(32),
            AppButtonSize.small => const Size.square(40),
            AppButtonSize.medium => const Size.square(48),
            AppButtonSize.large => const Size.square(56),
            AppButtonSize.extraLarge => const Size.square(64),
          },
          elevation: 0,
          shape: _shape,
        );
    }
  }

  EdgeInsetsGeometry get _padding {
    if (padding != null) return padding!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.s2, vertical: AppSpacing.s1);
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.s3, vertical: AppSpacing.s2);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.s4, vertical: AppSpacing.s3);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.s5, vertical: AppSpacing.s4);
      case AppButtonSize.extraLarge:
        return const EdgeInsets.symmetric(horizontal: AppSpacing.s6, vertical: AppSpacing.s5);
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
        return AppFonts.size14Medium;
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
        return const Size(64, 36);
      case AppButtonSize.medium:
        return const Size(72, 40);
      case AppButtonSize.large:
        return const Size(88, 48);
      case AppButtonSize.extraLarge:
        return const Size(112, 56);
    }
  }

  Size? get _maximumSize {
    if (maximumSize != null) return maximumSize!;

    switch (size) {
      case AppButtonSize.extraSmall:
        return const Size(120, 28);
      case AppButtonSize.small:
        return const Size(160, 36);
      case AppButtonSize.medium:
        return const Size(200, 40);
      case AppButtonSize.large:
        return const Size(240, 48);
      case AppButtonSize.extraLarge:
        return const Size(320, 56);
    }
  }

  OutlinedBorder? get _shape {
    if (shape != null) return shape!;

    return const RoundedRectangleBorder(borderRadius: BorderRadius.all(AppRadius.lg));
  }

  @override
  Widget build(BuildContext context) {
    return _buttonBuilder(context);
  }

  Widget _buttonBuilder(BuildContext context) {
    switch (style) {
      case AppButtonStyle.filled:
        if (icon != null) {
          return FilledButton.icon(
            label: _labelBuilder(context),
            onPressed: onPressed,
            onLongPress: onLongPress,
            icon: icon!,
            style: _buttonStyle(context),
          );
        }
        return FilledButton(onPressed: onPressed, style: _buttonStyle(context), child: _labelBuilder(context));
      case AppButtonStyle.outlined:
        if (icon != null) {
          return OutlinedButton.icon(
            label: _labelBuilder(context),
            onPressed: onPressed,
            onLongPress: onLongPress,
            icon: icon!,
            style: _buttonStyle(context),
          );
        }
        return OutlinedButton(onPressed: onPressed, style: _buttonStyle(context), child: _labelBuilder(context));
      case AppButtonStyle.text:
        if (icon != null) {
          return TextButton.icon(
            label: _labelBuilder(context),
            onPressed: onPressed,
            onLongPress: onLongPress,
            icon: icon!,
            style: _buttonStyle(context),
          );
        }
        return TextButton(onPressed: onPressed, style: _buttonStyle(context), child: _labelBuilder(context));
      case AppButtonStyle._icon:
        return IconButton(onPressed: onPressed, icon: icon!, onLongPress: onLongPress, style: _buttonStyle(context));
    }
  }

  Widget _labelBuilder(BuildContext context) {
    return Flexible(child: AppText(label!, textAlign: TextAlign.center));
  }
}
