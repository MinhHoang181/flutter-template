import 'package:flutter/material.dart';
import 'package:template/core/theme/app_spacing.dart';

class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.child,
    this.backgroundColor,
    this.hasShadow = false,
    this.minimum = const EdgeInsets.only(
      top: AppSpacing.s3,
      left: AppSpacing.s4,
      right: AppSpacing.s4,
      bottom: AppSpacing.s6,
    ),
  });

  final Widget child;

  final Color? backgroundColor;

  final bool hasShadow;

  final EdgeInsets minimum;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  spreadRadius: 0,
                  blurRadius: 2,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: SafeArea(minimum: minimum, child: child),
    );
  }
}
