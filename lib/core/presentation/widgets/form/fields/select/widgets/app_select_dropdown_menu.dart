import 'package:flutter/material.dart';

import '../../../../../../theme/app_radius.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../../../utils/either.dart';
import '../../../../app_icon.dart';
import '../../../../app_text.dart';
import '../base/app_select_typedefs.dart';
import '../data_source/app_select_data_source.dart';
import 'app_select_paginated_list_view.dart';

part 'src/app_select_dropdown_menu_props.dart';
part 'src/app_select_dropdown_menu_route.dart';

enum _UnselectedValue { value }

const _UnselectedValue _unselectedValue = _UnselectedValue.value;

/// Dropdown menu widget for selecting a single item
///
/// This widget displays a dropdown menu overlay that can show either a fixed
/// list of items or a paginated list loaded from a data source.
///
/// Features:
/// - Single selection only
/// - Fixed list or paginated data source support
/// - Material Design styling
/// - Automatic positioning relative to trigger widget
/// - Customizable menu alignment and constraints
///
/// Usage with fixed list:
/// ```dart
/// final result = await AppSelectDropdownMenu.showSingle<String>(
///   context,
///   items: ['Option 1', 'Option 2', 'Option 3'],
///   selectedItem: currentValue,
/// );
/// ```
///
/// Usage with data source:
/// ```dart
/// final result = await AppSelectDropdownMenu.showSingle<Customer>(
///   context,
///   dataSource: customerDataSource,
///   selectedItem: currentCustomer,
///   itemDisplay: (customer) => customer.name,
///   itemIdentity: (customer) => customer.id,
/// );
/// ```
///
/// Returns:
/// - `Right(value)` when a selection is made
/// - `Left(null)` when unselected (tapping already selected item)
/// - `null` when cancelled (tapping outside)
class AppSelectDropdownMenu<T> extends StatefulWidget {
  const AppSelectDropdownMenu._({
    required this.dataSource,
    required this.selectedItem,
    required this.itemDisplay,
    required this.itemIdentity,
  });

  /// Show dropdown menu for single selection
  ///
  /// Use [items] for fixed list or [dataSource] for paginated/custom data source.
  /// If both are provided, [dataSource] takes priority.
  static Future<Either<Null, T>?> showSingle<T>(
    BuildContext context, {
    DropdownMenuProps menuProps = const DropdownMenuProps(),
    BoxConstraints constraints = const BoxConstraints(),
    required AppSelectDataSource<T> dataSource,
    T? selectedItem,
    required AppItemDisplay<T> itemDisplay,
    required AppItemIdentity<T> itemIdentity,
  }) async {
    final dropdownObject = context.findRenderObject()! as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;

    final result = await _showMenu<T>(
      context: context,
      menuModeProps: menuProps,
      position: _position(dropdownObject, overlay, constraints, menuProps),
      child: AppSelectDropdownMenu<T>._(
        dataSource: dataSource,
        selectedItem: selectedItem,
        itemDisplay: itemDisplay,
        itemIdentity: itemIdentity,
      ),
    );

    return _parseResult(result);
  }

  static Either<Null, T>? _parseResult<T>(Object? result) {
    if (result == null) return null;

    if (result == _unselectedValue) {
      return const Left(null);
    }

    if (result is T) {
      return Right(result as T);
    }

    return null;
  }

  /// Data source for loading items
  final AppSelectDataSource<T> dataSource;

  /// Currently selected item
  final T? selectedItem;

  /// Item display function
  final AppItemDisplay<T> itemDisplay;

  /// Item identity function for comparison
  final AppItemIdentity<T> itemIdentity;

  @override
  State<AppSelectDropdownMenu<T>> createState() =>
      _AppSelectDropdownMenuState<T>();
}

class _AppSelectDropdownMenuState<T> extends State<AppSelectDropdownMenu<T>> {
  void _onTap(T item) {
    // Close immediately on tap
    if (_isSelected(item)) {
      Navigator.of(context).pop(_unselectedValue);
    } else {
      Navigator.of(context).pop(item);
    }
  }

  bool _isSelected(T item) {
    if (widget.selectedItem == null) return false;
    return widget.itemIdentity(widget.selectedItem as T) ==
        widget.itemIdentity(item);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 300, minWidth: 112),
        child: AppSelectPaginatedListView<T>(
          shrinkWrap: true,
          dataSource: widget.dataSource,
          itemDisplay: widget.itemDisplay,
          getItemIdentity: widget.itemIdentity,
          itemBuilder: _buildMenuItem,
          separatorBuilder: _buildDivider,
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, T item) {
    final isSelected = _isSelected(item);

    return InkWell(
      onTap: () => _onTap(item),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: AppSpacing.s2,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: AppText(
                widget.itemDisplay(item),
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
                maxLines: null,
              ),
            ),
            if (isSelected) ...[
              Transform.translate(
                offset: const Offset(0, 2),
                child: AppIcon(
                  icon: Icons.check,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context, int index) {
    return const SizedBox.shrink();
  }
}
