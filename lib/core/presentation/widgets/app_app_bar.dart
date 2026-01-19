import 'package:flutter/material.dart';
import 'package:template/core/presentation/widgets/app_back_button.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_theme.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.toolbarHeight = AppAppBarTheme.height,
    this.bottom,
    this.actions,
    this.leading = const AppBackButton(),
    this.backgroundColor,
    this.foregroundColor,
    this.primary = true,
    this.flexibleSpace,
  });

  final String? title;

  final Widget? titleWidget;

  final List<Widget>? actions;

  final double toolbarHeight;

  final PreferredSizeWidget? bottom;

  final Widget? leading;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final bool primary;

  final Widget? flexibleSpace;

  @override
  Size get preferredSize =>
      Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:
          titleWidget ??
          AppText(
            title,
            style: AppFonts.size18Semi.copyWith(color: foregroundColor),
            textAlign: TextAlign.center,
          ),
      toolbarHeight: toolbarHeight,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      bottom: bottom,
      actions: actions,
      automaticallyImplyLeading: false,
      leading: leading,
      scrolledUnderElevation: 0,
      primary: primary,
      flexibleSpace: flexibleSpace,
    );
  }
}
