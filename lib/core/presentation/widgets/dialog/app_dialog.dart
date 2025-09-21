import 'package:flutter/material.dart';

import 'package:template/core/theme/app_radius.dart';
import 'package:template/core/theme/app_spacing.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.header,
    required this.content,
    required this.button,
  });

  final Widget? header;

  final Widget content;

  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(AppSpacing.s4),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(AppRadius.xxl)),
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (header != null) ...[header!],
            content,
            if (button != null) ...[button!],
          ],
        ),
      ),
    );
  }
}
