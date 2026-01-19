import 'package:flutter/material.dart';

import '../base/base_app_select_field.dart';
import '../data_source/app_select_data_source.dart';
import '../display/app_select_display_strategy.dart';
import '../widgets/app_select_dropdown_menu.dart';
import 'app_select_popup_strategy.dart';

/// Dropdown popup strategy for single select.
///
/// Displays a Material Design dropdown menu for selecting a single item.
/// Automatically uses paginated dropdown when data source supports pagination.
class AppSelectDropdownPopup<T> extends AppSelectPopupStrategy<T, T> {
  const AppSelectDropdownPopup({
    required super.itemDisplay,
    this.menuProps = const DropdownMenuProps(),
    this.constraints = const BoxConstraints(),
  });

  /// Properties for customizing the dropdown menu appearance.
  final DropdownMenuProps menuProps;

  /// Constraints for the dropdown menu size.
  final BoxConstraints constraints;

  @override
  Future<T?> show(
    BuildContext context, {
    required BaseAppSelectFieldState<T?, T> state,
    required AppSelectDataSource<T> dataSource,
    required AppSelectDisplayStrategy<T?, T> displayStrategy,
  }) async {
    final T? value = state.control.value;

    final result = await AppSelectDropdownMenu.showSingle<T>(
      context,
      menuProps: menuProps,
      constraints: constraints,
      dataSource: dataSource,
      selectedItem: value,
      itemDisplay: itemDisplay,
      itemIdentity: state.widget.itemIdentity,
    );

    return result?.rightOrNull;
  }
}
