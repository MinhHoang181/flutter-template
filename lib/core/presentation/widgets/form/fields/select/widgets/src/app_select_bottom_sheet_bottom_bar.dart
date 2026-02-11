part of '../app_select_bottom_sheet.dart';

class _AppSelectBottomSheetBottomBar extends StatelessWidget {
  const _AppSelectBottomSheetBottomBar({
    required this.onReset,
    required this.onConfirm,
  });

  final VoidCallback onReset;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s4,
      children: [
        Expanded(
          child: AppButton.filled(
            label: context.text(
              'core.bottomsheet.select_bottom_sheet.buttons.reset',
              defaultValue: 'Đặt lại',
            ),
            style: AppFilledButtonStyle.secondary,
            onPressed: onReset,
          ),
        ),
        Expanded(
          child: AppButton.filled(
            label: context.text(
              'core.bottomsheet.select_bottom_sheet.buttons.confirm',
              defaultValue: 'Hoàn tất',
            ),
            onPressed: onConfirm,
          ),
        ),
      ],
    );
  }
}
