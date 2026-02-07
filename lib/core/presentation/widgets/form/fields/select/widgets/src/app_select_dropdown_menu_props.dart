part of '../app_select_dropdown_menu.dart';

enum DropdownMenuAlign {
  bottomStart,
  bottomCenter,
  bottomEnd,
}

class DropdownMenuProps {
  const DropdownMenuProps({
    this.align,
    this.barrierLabel,
    this.elevation,
    this.shape,
    this.barrierColor,
    this.backgroundColor,
    this.barrierDismissible = true,
    this.clipBehavior = Clip.hardEdge,
    this.borderOnForeground = false,
    this.borderRadius = const BorderRadius.all(AppRadius.lg),
    this.shadowColor,
    this.color,
    this.popUpAnimationStyle,
    this.semanticLabel,
    this.surfaceTintColor,
    this.margin,
  });
  final DropdownMenuAlign? align;
  final ShapeBorder? shape;
  final double? elevation;
  final Color? barrierColor;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final Clip clipBehavior;
  final BorderRadiusGeometry? borderRadius;
  final Color? shadowColor;
  final bool borderOnForeground;
  final String? barrierLabel;
  final AnimationStyle? popUpAnimationStyle;
  final Color? color;
  final String? semanticLabel;
  final Color? surfaceTintColor;
  final EdgeInsets? margin;
}
