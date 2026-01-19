part of '../app_button.dart';

enum AppIconButtonStyle { filled, outlined, subtlest, regular }

class AppIconButton extends AppButton {
  const AppIconButton({
    super.key,
    required super.icon,
    required super.onPressed,
    super.onLongPress,
    this.style = AppIconButtonStyle.filled,
    super.size = AppButtonSize.small,
    super.iconAlignment,
    super.padding,
    super.textStyle,
    super.iconSize,
    super.minimumSize,
    super.maximumSize,
    super.backgroundColor,
    super.foregroundColor,
    super.shape,
    super.visualDensity,
    this.tooltip,
  }) : super._();

  final AppIconButtonStyle style;

  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final Widget iconWidget = icon is Widget
        ? icon! as Widget
        : AppIcon(icon: icon, size: null);

    return IconButton(
      onPressed: onPressed,
      icon: iconWidget,
      onLongPress: onLongPress,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor:
            backgroundColor ??
            switch (style) {
              AppIconButtonStyle.filled => context.colorScheme.primary,
              AppIconButtonStyle.outlined => Colors.transparent,
              AppIconButtonStyle.subtlest => Colors.transparent,
              AppIconButtonStyle.regular => Colors.transparent,
            },
        foregroundColor:
            foregroundColor ??
            switch (style) {
              AppIconButtonStyle.filled => context.colorScheme.onPrimary,
              AppIconButtonStyle.outlined => context.colorScheme.onSurface,
              AppIconButtonStyle.subtlest =>
                context.colorScheme.onSurfaceVariant,
              AppIconButtonStyle.regular => context.colorScheme.onSurface,
            },
        padding: EdgeInsets.zero,
        iconSize: switch (size) {
          AppButtonSize.extraSmall => 16,
          AppButtonSize.small => 20,
          AppButtonSize.medium => 24,
          AppButtonSize.large => 28,
          AppButtonSize.extraLarge => 32,
        },
        fixedSize: switch (size) {
          AppButtonSize.extraSmall => const Size.square(32),
          AppButtonSize.small => const Size.square(40),
          AppButtonSize.medium => const Size.square(48),
          AppButtonSize.large => const Size.square(56),
          AppButtonSize.extraLarge => const Size.square(64),
        },
        shape:
            shape ??
            switch (style) {
              AppIconButtonStyle.filled => const CircleBorder(),
              AppIconButtonStyle.outlined => CircleBorder(
                side: BorderSide(
                  color: context.colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              AppIconButtonStyle.subtlest => const CircleBorder(),
              AppIconButtonStyle.regular => const CircleBorder(),
            },
        visualDensity: _visualDensity,
      ),
    );
  }
}
