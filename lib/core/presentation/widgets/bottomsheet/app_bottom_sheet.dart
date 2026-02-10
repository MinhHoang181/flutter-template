import 'package:flutter/material.dart';
import 'package:icon/icon.dart';
import 'package:template/app/app.dart';

import '../../../theme/app_fonts.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../app_bottom_bar.dart';
import '../app_button/app_button.dart';
import '../app_icon.dart';
import '../app_text.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    this.height,
    this.header,
    required this.content,
    this.bottom,
  });

  final double? height;

  final Widget? header;

  final Widget content;

  final Widget? bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: AppRadius.xxxl),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) header!,
          content,
          if (bottom != null) bottom!,
        ],
      ),
    );
  }
}

class AppBottomSheetHeader extends StatelessWidget {
  const AppBottomSheetHeader({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.centerMiddle = true,
  });

  final String title;

  final Widget? leading;

  final Widget? trailing;

  final bool centerMiddle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s4,
      ),
      child: NavigationToolbar(
        centerMiddle: centerMiddle,
        leading: leading,
        middle: AppText(
          title,
          style: AppFonts.size16Semi,
          maxLines: 1,
          textAlign: centerMiddle ? TextAlign.center : TextAlign.start,
        ),
        trailing: trailing ?? closeButton(context),
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return AppButton.icon(
      icon: const AppIcon(icon: PhosphorIconsRegular.x, size: null),
      style: AppIconButtonStyle.regular,
      size: AppButtonSize.small,
      onPressed: App.closeBottomSheet,
    );
  }
}

class AppBottomSheetButton extends StatelessWidget {
  const AppBottomSheetButton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppBottomBar(
      hasShadow: false,
      backgroundColor: Colors.transparent,
      child: child,
    );
  }
}
