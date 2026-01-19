import 'package:flutter/material.dart';

import '../base/base_app_select_field.dart';
import '../data_source/app_select_data_source.dart';
import '../display/app_select_display_strategy.dart';
import '../widgets/app_select_bottom_sheet.dart';
import 'app_select_popup_strategy.dart';

/// Bottomsheet popup strategy for multi select.
///
/// Displays a Material Design bottomsheet for selecting multiple items.
/// Automatically uses paginated bottomsheet when data source supports pagination.
class AppMultiSelectBottomSheetPopup<T>
    extends AppSelectPopupStrategy<List<T>, T> {
  const AppMultiSelectBottomSheetPopup({
    required this.title,
    required super.itemDisplay,
    this.itemLeadingBuilder,
    this.itemTrailingBuilder,
    this.showSearchBar = false,
    this.isScrollControlled = false,
  });

  /// Title displayed at the top of the bottomsheet.
  final String title;

  final AppSelectBottomSheetItemLeadingBuilder<T>? itemLeadingBuilder;
  final AppSelectBottomSheetItemTrailingBuilder<T>? itemTrailingBuilder;

  /// Whether to show search bar
  final bool showSearchBar;

  /// Whether the bottomsheet should be scroll controlled
  final bool isScrollControlled;

  @override
  Future<List<T>?> show(
    BuildContext context, {
    required BaseAppSelectFieldState<List<T>, T> state,
    required AppSelectDataSource<T> dataSource,
    required AppSelectDisplayStrategy<List<T>, T> displayStrategy,
  }) async {
    final List<T>? value = state.control.value;

    final result = await AppSelectBottomSheet.showMultiple<T>(
      label: title,
      dataSource: dataSource,
      selectedItems: value,
      itemDisplay: itemDisplay,
      itemIdentity: state.widget.itemIdentity,
      itemLeadingBuilder: itemLeadingBuilder,
      itemTrailingBuilder: itemTrailingBuilder,
      showSearchBar: showSearchBar,
      isScrollControlled: isScrollControlled,
    );

    return result?.rightOrNull;
  }
}
