import 'package:flutter/material.dart';
import 'package:template/core/presentation/widgets/app_back_button.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_theme.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    required this.title,
    this.toolbarHeight = AppAppBarTheme.kToolbarHeight,
    this.bottom,
    this.actions,
    this.leading = const AppBackButton(),
  });

  final String title;

  final List<Widget>? actions;

  final double toolbarHeight;

  final PreferredSizeWidget? bottom;

  final Widget? leading;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: AppText(title, style: AppFonts.size18Semi, textAlign: TextAlign.center),
      toolbarHeight: toolbarHeight,
      bottom: bottom,
      actions: actions,
      automaticallyImplyLeading: false,
      leading: leading,
    );
  }
}
