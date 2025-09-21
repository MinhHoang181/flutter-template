import 'package:flutter/material.dart';
import 'package:template/app/app.dart';
import 'package:template/core/presentation/widgets/app_bottom_bar.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_radius.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({super.key, this.height, this.header, required this.content, this.button});

  final double? height;

  final Widget? header;

  final Widget content;

  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: AppRadius.xxxl),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [if (header != null) header!, content, if (button != null) button!],
      ),
    );
  }
}

class AppBottomSheetHeader extends StatelessWidget {
  const AppBottomSheetHeader({super.key, required this.title, this.leading, this.trailing, this.centerMiddle = true});

  final String title;

  final Widget? leading;

  final Widget? trailing;

  final bool centerMiddle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
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
    return IconButton(icon: const Icon(Icons.close_rounded, size: 24), onPressed: App.closeBottomSheet);
  }
}

class AppBottomSheetButton extends StatelessWidget {
  const AppBottomSheetButton({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppBottomBar(hasShadow: false, backgroundColor: Colors.transparent, child: child);
  }
}
