import 'package:flutter/material.dart';
import 'package:template/app/app.dart';

import 'package:template/core/presentation/widgets/app_app_bar.dart';
import 'package:template/core/presentation/widgets/app_button/app_button.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_spacing.dart';
import 'package:template/gen/locale_keys.gen.dart';

/// A screen that displays an error message when a navigation failure occurs.
class NavigationErrorScreen extends StatelessWidget {
  const NavigationErrorScreen({super.key, this.error, this.onBackHome});

  final String? error;

  final void Function(BuildContext context)? onBackHome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: context.text(
          LocaleKeys.core.error_screen.app_bar,
          defaultValue: 'Lỗi điều hướng',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.s4,
      children: [
        AppText(
          error ??
              context.text(
                LocaleKeys.core.error_screen.message,
                defaultValue: 'Đã có lỗi xảy ra, vui lòng thử lại',
              ),
          textAlign: TextAlign.center,
          maxLines: null,
          style: AppFonts.size16Regular,
        ),
        if (onBackHome != null) ...[
          AppButton.filled(
            label: context.text(
              LocaleKeys.core.error_screen.back_home,
              defaultValue: 'Quay về trang chủ',
            ),
            onPressed: () => onBackHome!(context),
            size: AppButtonSize.large,
          ),
        ],
      ],
    );
  }
}
