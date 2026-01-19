import 'package:flutter/material.dart';

import '../base/app_select_typedefs.dart';
import '../base/base_app_select_field.dart';
import '../data_source/app_select_data_source.dart';
import '../display/app_select_display_strategy.dart';

/// Abstract popup strategy for showing selection UI.
///
/// Defines how the selection popup is displayed. Use [AppSelectBottomSheetPopup],
/// [AppMultiSelectBottomSheetPopup], or [AppSelectDropdownPopup] for built-in
/// implementations.
///
/// Generic parameters:
/// - [TValue]: FormControl value type (T? for single, List`<`T`>` for multi)
/// - [TItem]: Type of individual item
abstract class AppSelectPopupStrategy<TValue, TItem> {
  const AppSelectPopupStrategy({required this.itemDisplay});

  /// Function to display an item as text.
  final AppItemDisplay<TItem> itemDisplay;

  /// Show popup and return selected value.
  ///
  /// Returns the selected value or `null` if cancelled.
  Future<TValue?> show(
    BuildContext context, {
    required BaseAppSelectFieldState<TValue, TItem> state,
    required AppSelectDataSource<TItem> dataSource,
    required AppSelectDisplayStrategy<TValue, TItem> displayStrategy,
  });
}
