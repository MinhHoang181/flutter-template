part of '../app_notify_dialog.dart';

class _AppErrorDialog extends AppNotifyDialog {
  const _AppErrorDialog({
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
      icon: Icons.close_rounded,
      color: AppColors.red600,
      title: title,
      message: message,
    );
  }

  @override
  Widget buttonBuilder(BuildContext context) {
    return AppNotifyDialogButton(
      primaryLabel: primaryLabel,
      onPrimaryPressed: onPrimaryPressed,
      primaryColor: AppColors.red600,
      secondaryLabel:
          secondaryLabel ??
          context.text(
            LocaleKeys.core.dialog.error.button.close,
            defaultValue: 'Đóng',
          ),
      onSecondaryPressed: onSecondaryPressed ?? () => App.closeDialog(),
      secondaryColor: null,
    );
  }
}
