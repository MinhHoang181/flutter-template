import 'package:flutter/material.dart';

import '../widgets/date_time_picker_bottom_sheet.dart';
import 'app_date_popup_strategy.dart';

/// Bottom sheet popup strategy for date/time picker.
///
/// Uses [DateTimePickerBottomSheet] to show a Cupertino-style picker in a bottom sheet.
/// Supports date-only, time-only, or date+time selection modes.
class AppDateTimeBottomSheetPopup extends AppDatePopupStrategy {
  const AppDateTimeBottomSheetPopup({
    this.mode = DateTimePickerBottomSheetMode.dateTime,
    this.minuteInterval = 1,
  });

  /// Picker mode: date, time, or dateTime.
  final DateTimePickerBottomSheetMode mode;

  /// Minute interval for time picker (e.g., 15 for 15-minute intervals).
  final int minuteInterval;

  @override
  Future<DateTime?> show(
    BuildContext context, {
    required DateTime? currentValue,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
  }) async {
    return DateTimePickerBottomSheet.show(
      value: currentValue ?? initialDate,
      mode: mode,
      minDate: minDate,
      maxDate: maxDate,
      minuteInterval: minuteInterval,
    );
  }
}
