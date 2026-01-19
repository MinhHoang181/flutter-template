part of '../app_notify_dialog.dart';

class _AppDevelopDialog extends AppNotifyDialog {
  _AppDevelopDialog({super.key, required this.stackTrace})
    : super(
        title: App.text(
          LocaleKeys.core.dialog.develop.title,
          defaultValue: 'Đang phát triển!',
        ),
        message: App.text(
          LocaleKeys.core.dialog.develop.message,
          defaultValue: 'Tính năng này đang được phát triển!',
        ),
      ) {
    if (kDebugMode) {
      log('Check where this dialog is called', stackTrace: stackTrace);
    }
  }

  final StackTrace stackTrace;

  @override
  Widget contentBuilder(BuildContext context) {
    return AppNotifyDialogContent(
      icon: Icons.build_rounded,
      color: AppColors.primary,
      title: title,
      message: message,
    );
  }

  @override
  Widget buttonBuilder(BuildContext context) {
    return AppNotifyDialogButton(
      primaryLabel: null,
      onPrimaryPressed: null,
      primaryColor: null,
      secondaryLabel: context.text(
        LocaleKeys.core.dialog.develop.button.close,
        defaultValue: 'Đóng',
      ),
      onSecondaryPressed: App.closeDialog,
      secondaryColor: null,
    );
  }
}
