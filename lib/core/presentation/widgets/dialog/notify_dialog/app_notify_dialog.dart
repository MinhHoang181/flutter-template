import 'package:flutter/material.dart';
import 'package:template/app/app.dart';
import 'package:template/core/presentation/widgets/app_button.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/presentation/widgets/dialog/app_dialog.dart';
import 'package:template/core/theme/app_colors.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_spacing.dart';
import 'package:template/core/theme/app_theme.dart';
import 'package:template/gen/locale_keys.gen.dart';

part 'src/app_confirm_dialog.dart';
part 'src/app_error_dialog.dart';
part 'src/app_success_dialog.dart';
part 'src/app_warning_dialog.dart';

abstract class AppNotifyDialog extends StatelessWidget {
  const AppNotifyDialog({super.key, required this.title, required this.message});

  factory AppNotifyDialog.confirm({
    Key? key,
    String? title,
    required String message,
    String? primaryLabel,
    String? secondaryLabel,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    return _ConfirmDialog(
      key: key,
      title: title ?? App.text(LocaleKeys.core.dialog.confirm.title, defaultValue: 'Thực hiện hành động!'),
      message: message,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
    );
  }

  factory AppNotifyDialog.warning({
    Key? key,
    String? title,
    required String message,
    String? primaryLabel,
    String? secondaryLabel,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    return _AppWarningDialog(
      key: key,
      title: title ?? App.text(LocaleKeys.core.dialog.warning.title, defaultValue: 'Cảnh báo!'),
      message: message,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
    );
  }

  factory AppNotifyDialog.success({
    Key? key,
    String? title,
    required String message,
    String? primaryLabel,
    String? secondaryLabel,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    return _AppSuccessDialog(
      key: key,
      title: title ?? App.text(LocaleKeys.core.dialog.success.title, defaultValue: 'Thành công!'),
      message: message,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
    );
  }

  factory AppNotifyDialog.error({
    Key? key,
    String? title,
    required String message,
    String? primaryLabel,
    String? secondaryLabel,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
  }) {
    return _AppErrorDialog(
      key: key,
      title: title ?? App.text(LocaleKeys.core.dialog.error.title, defaultValue: 'Đã có lỗi xảy ra!'),
      message: message,
      primaryLabel: primaryLabel,
      secondaryLabel: secondaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      onSecondaryPressed: onSecondaryPressed,
    );
  }

  final String title;

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppDialog(content: contentBuilder(context), button: buttonBuilder(context));
  }

  Widget contentBuilder(BuildContext context);

  Widget buttonBuilder(BuildContext context);
}

class AppNotifyDialogContent extends StatelessWidget {
  const AppNotifyDialogContent({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.message,
  });

  final IconData icon;

  final Color color;

  final String title;

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 42,
            width: 42,
            padding: const EdgeInsets.all(AppSpacing.s1),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, size: 24, color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.s4),
          AppText(
            title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: AppFonts.size18Semi.copyWith(color: color),
          ),
          const SizedBox(height: AppSpacing.s2),
          AppText(
            message,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: AppFonts.size16Regular.copyWith(color: context.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class AppNotifyDialogButton extends StatelessWidget {
  const AppNotifyDialogButton({
    super.key,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    required this.secondaryLabel,
    required this.onSecondaryPressed,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final String? primaryLabel;

  final String? secondaryLabel;

  final VoidCallback? onPrimaryPressed;

  final VoidCallback? onSecondaryPressed;

  final Color? primaryColor;

  final Color? secondaryColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.s4, right: AppSpacing.s4, bottom: AppSpacing.s4),
      child: Row(
        spacing: AppSpacing.s4,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (secondaryLabel != null) secondaryButtonBuilder(context),
          if (primaryLabel != null) primaryButtonBuilder(context),
        ],
      ),
    );
  }

  Widget primaryButtonBuilder(BuildContext context) {
    return AppButton(
      label: primaryLabel ?? '',
      style: AppButtonStyle.filled,
      onPressed: onPrimaryPressed,
      size: AppButtonSize.medium,
      backgroundColor: primaryColor,
    );
  }

  Widget secondaryButtonBuilder(BuildContext context) {
    return AppButton(
      label: secondaryLabel ?? '',
      style: AppButtonStyle.outlined,
      onPressed: onSecondaryPressed,
      size: AppButtonSize.medium,
      backgroundColor: secondaryColor,
    );
  }
}
