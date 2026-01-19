part of '../app_button.dart';

enum AppFilledButtonStyle { primary, secondary }

class AppFilledButton extends AppTextButton {
  const AppFilledButton({
    super.key,
    required super.label,
    super.icon,
    required super.onPressed,
    super.onLongPress,
    this.style = AppFilledButtonStyle.primary,
    super.size,
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
  }) : super();

  final AppFilledButtonStyle style;

  @override
  ButtonStyle _buttonStyle(BuildContext context) {
    final Color? backgroundColor =
        super.backgroundColor ??
        switch (style) {
          AppFilledButtonStyle.primary => null,
          AppFilledButtonStyle.secondary =>
            context.colorScheme.surfaceContainerHighest,
        };

    final Color? foregroundColor =
        super.foregroundColor ??
        switch (style) {
          AppFilledButtonStyle.primary => null,
          AppFilledButtonStyle.secondary => context.colorScheme.onSurface,
        };

    return FilledButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      padding: _padding,
      textStyle: _textStyle,
      iconSize: _iconSize,
      iconAlignment: iconAlignment,
      minimumSize: _minimumSize,
      maximumSize: _maximumSize,
      shape: shape,
      visualDensity: _visualDensity,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      final Widget iconWidget = icon is Widget
          ? icon! as Widget
          : AppIcon(icon: icon, size: null);

      return FilledButton.icon(
        label: _labelBuilder(context),
        onPressed: onPressed,
        onLongPress: onLongPress,
        icon: iconWidget,
        style: _buttonStyle(context),
      );
    }
    return FilledButton(
      onPressed: onPressed,
      style: _buttonStyle(context),
      child: _labelBuilder(context),
    );
  }
}
