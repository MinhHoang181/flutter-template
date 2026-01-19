import 'package:flutter/material.dart';

/// Abstract popup strategy for showing date/time picker UI.
///
/// Defines how the date/time picker popup is displayed.
/// Use [AppDateDialogPopup] or [AppDateTimeBottomSheetPopup] for built-in
/// implementations.
abstract class AppDatePopupStrategy {
  const AppDatePopupStrategy();

  /// Show popup and return selected DateTime.
  ///
  /// Returns the selected DateTime or `null` if cancelled.
  Future<DateTime?> show(
    BuildContext context, {
    required DateTime? currentValue,
    DateTime? initialDate,
    DateTime? minDate,
    DateTime? maxDate,
  });
}
