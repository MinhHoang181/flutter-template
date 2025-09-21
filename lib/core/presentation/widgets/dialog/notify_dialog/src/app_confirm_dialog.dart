part of '../app_notify_dialog.dart';

class _ConfirmDialog extends AppNotifyDialog {
  const _ConfirmDialog({
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
      icon: Icons.priority_high_rounded,
      color: AppColors.info,
      title: title,
      message: message,
    );
  }

  @override
  Widget buttonBuilder(BuildContext context) {
    return AppNotifyDialogButton(
      primaryLabel:
          primaryLabel ?? context.text(LocaleKeys.core.dialog.confirm.button.confirm, defaultValue: 'Xác nhận'),
      onPrimaryPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(true),
      primaryColor: context.colorScheme.primary,
      secondaryLabel: secondaryLabel ?? context.text(LocaleKeys.core.dialog.confirm.button.cancel, defaultValue: 'Hủy'),
      onSecondaryPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(false),
      secondaryColor: null,
    );
  }
}
