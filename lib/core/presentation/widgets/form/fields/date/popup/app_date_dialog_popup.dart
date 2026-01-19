import 'package:flutter/material.dart';

import '../widgets/date_select_dialog.dart';
import 'app_date_popup_strategy.dart';

/// Dialog popup strategy for date picker.
///
/// Uses [DatePickerDialog] to show a calendar dialog for date selection.
/// This is suitable for date-only selection without time.
class AppDateDialogPopup extends AppDatePopupStrategy {
  const AppDateDialogPopup();

  @override
  Future<DateTime?> show(
    BuildContext context, {
    required DateTime? currentValue,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    return DateSelectDialog.showSingle(
      initialDate: currentValue ?? initialDate,
      minDate: minDate,
      maxDate: maxDate,
    );
  }
}
