part of '../app_notify_dialog.dart';

class _AppSuccessDialog extends AppNotifyDialog {
  const _AppSuccessDialog({
    super.key,
    required super.title,
    required super.message,
    this.primaryLabel,
    this.secondaryLabel,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
  });

  final String? primaryLabel;

  final String? secondaryLabel;

  final VoidCallback? onPrimaryPressed;

  final VoidCallback? onSecondaryPressed;

  @override
  Widget contentBuilder(BuildContext context) {
    return AppNotifyDialogContent(
      icon: Icons.check_rounded,
      color: AppColors.green700,
      title: title,
      message: message,
    );
  }

  @override
  Widget buttonBuilder(BuildContext context) {
    return AppNotifyDialogButton(
      primaryLabel: primaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      primaryColor: AppColors.green700,
      secondaryLabel:
          secondaryLabel ??
          context.text(
            LocaleKeys.core.dialog.success.button.close,
            defaultValue: 'Đóng',
          ),
      onSecondaryPressed: onSecondaryPressed ?? () => App.closeDialog(),
      secondaryColor: null,
    );
  }
}
