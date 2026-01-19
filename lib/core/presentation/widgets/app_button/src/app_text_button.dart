part of '../app_button.dart';

class AppTextButton extends AppButton {
  const AppTextButton({
    super.key,
    required this.label,
    super.icon,
    required super.onPressed,
    super.onLongPress,
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
  }) : super._();

  final String label;

  ButtonStyle _buttonStyle(BuildContext context) {
    return TextButton.styleFrom(
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

      return TextButton.icon(
        label: _labelBuilder(context),
        onPressed: onPressed,
        onLongPress: onLongPress,
        icon: iconWidget,
        style: _buttonStyle(context),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: _buttonStyle(context),
      child: _labelBuilder(context),
    );
  }

  Widget _labelBuilder(BuildContext context) {
    return AppText(label, textAlign: TextAlign.center);
  }
}
