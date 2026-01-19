import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../theme/app_colors/app_colors.dart';
import '../../../theme/app_fonts.dart';
import '../../../theme/app_spacing.dart';
import '../app_text.dart';
import 'reactive_form_extension.dart';

class AppFormFieldBuilder extends StatelessWidget {
  const AppFormFieldBuilder({
    super.key,
    required this.label,
    this.labelStyle = AppFonts.size14Medium,
    required this.formControl,
    required this.field,
  });

  final String label;

  final TextStyle labelStyle;

  final FormControl? formControl;

  final Widget field;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s2,
      children: [
        labelBuilder(context),
        Theme(
          data: Theme.of(context).copyWith(disabledColor: AppColors.gray700),
          child: field,
        ),
      ],
    );
  }

  Widget labelBuilder(BuildContext context) {
    return AppText.rich(
      TextSpan(
        children: [
          TextSpan(text: label),
          if (formControl?.isRequired ?? false) ...[
            TextSpan(
              text: ' *',
              style: labelStyle.copyWith(color: AppColors.red600),
            ),
          ],
        ],
      ),
      style: labelStyle.copyWith(color: AppColors.gray900),
      maxLines: 1,
    );
  }
}
