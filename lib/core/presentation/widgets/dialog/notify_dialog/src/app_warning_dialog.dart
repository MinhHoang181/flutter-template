part of '../app_notify_dialog.dart';

class _AppWarningDialog extends AppNotifyDialog {
  const _AppWarningDialog({
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
      icon: Icons.question_mark_rounded,
      color: AppColors.orange600,
      title: title,
      message: message,
    );
  }

  @override
  Widget buttonBuilder(BuildContext context) {
    return AppNotifyDialogButton(
      primaryLabel:
          primaryLabel ??
          context.text(
            LocaleKeys.core.dialog.warning.button.confirm,
            defaultValue: 'Xác nhận',
          ),
      onPrimaryPressed: onPrimaryPressed ?? () => App.pop(true),
      primaryColor: AppColors.orange600,
      secondaryLabel:
          secondaryLabel ??
          context.text(
            LocaleKeys.core.dialog.warning.button.cancel,
            defaultValue: 'Hủy',
          ),
      onSecondaryPressed: onSecondaryPressed ?? () => App.pop(false),
      secondaryColor: null,
    );
  }
}
