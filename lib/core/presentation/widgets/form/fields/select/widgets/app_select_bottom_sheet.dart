import 'package:flutter/material.dart';
import 'package:template/app/app.dart';

import '../../../../../../theme/app_colors/app_colors.dart';
import '../../../../../../theme/app_fonts.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../../../utils/either.dart';
import '../../../../app_button/app_button.dart';
import '../../../../app_text.dart';
import '../../../../bottomsheet/app_bottom_sheet.dart';
import '../data_source/app_select_data_source.dart';
import 'app_select_paginated_list_view.dart';

enum _AppSelectBottomSheetMode { single, multiple }

typedef AppSelectBottomSheetItemDisplay<T> = String Function(T item);
typedef AppSelectBottomSheetItemIdentity<T> = Object Function(T item);

typedef AppSelectBottomSheetItemLeadingBuilder<T> =
    Widget? Function(T item, bool selected);
typedef AppSelectBottomSheetItemTrailingBuilder<T> =
    Widget? Function(T item, bool selected);
typedef AppSelectBottomSheetItemOnTap<T> = void Function(T item, bool selected);

const double _kDefaultTileHeight = 50;
const double _kDefaultDividerHeight = 1;

enum _UnselectedValue { value }

const _UnselectedValue _unselectedValue = _UnselectedValue.value;

/// Bottomsheet for selecting items (single or multiple)
///
/// Supports both fixed list and paginated list via [AppSelectDataSource]
class AppSelectBottomSheet<T> extends StatefulWidget {
  const AppSelectBottomSheet._({
    super.key,
    required this.label,
    required this.dataSource,
    this.selectedItems,
    required this.itemDisplay,
    required this.itemIdentity,
    required this.mode,
    required this.minTileHeight,
    this.itemLeadingBuilder,
    this.itemTrailingBuilder,
    this.showSearchBar = false,
  });

  /// Show single select bottomsheet
  ///
  /// Use [items] for fixed list or [dataSource] for paginated/custom data source.
  /// If both are provided, [dataSource] takes priority.
  static Future<Either<Null, T>?> showSingle<T>({
    Key? key,
    required String label,
    required AppSelectDataSource<T> dataSource,
    T? selectedItem,
    required AppSelectBottomSheetItemDisplay<T> itemDisplay,
    required AppSelectBottomSheetItemIdentity<T> itemIdentity,
    double minTileHeight = _kDefaultTileHeight,
    AppSelectBottomSheetItemLeadingBuilder<T>? itemLeadingBuilder,
    AppSelectBottomSheetItemTrailingBuilder<T>? itemTrailingBuilder,
    bool showSearchBar = false,
    bool isScrollControlled = false,
  }) async {
    final result = await App.showBottomSheet(
      isScrollControlled: isScrollControlled,
      child: AppSelectBottomSheet<T>._(
        key: key,
        label: label,
        dataSource: dataSource,
        selectedItems: selectedItem != null ? [selectedItem] : null,
        itemDisplay: itemDisplay,
        itemIdentity: itemIdentity,
        mode: _AppSelectBottomSheetMode.single,
        minTileHeight: minTileHeight,
        itemLeadingBuilder: itemLeadingBuilder,
        itemTrailingBuilder: itemTrailingBuilder,
        showSearchBar: showSearchBar,
      ),
    );

    return _parseSingleResult<T>(result);
  }

  /// Show multi select bottomsheet
  ///
  /// Use [items] for fixed list or [dataSource] for paginated/custom data source.
  /// If both are provided, [dataSource] takes priority.
  static Future<Either<Null, List<T>>?> showMultiple<T>({
    Key? key,
    required String label,
    required AppSelectDataSource<T> dataSource,
    List<T>? selectedItems,
    required AppSelectBottomSheetItemDisplay<T> itemDisplay,
    required AppSelectBottomSheetItemIdentity<T> itemIdentity,
    double minTileHeight = _kDefaultTileHeight,
    AppSelectBottomSheetItemLeadingBuilder<T>? itemLeadingBuilder,
    AppSelectBottomSheetItemTrailingBuilder<T>? itemTrailingBuilder,
    bool showSearchBar = false,
    bool isScrollControlled = false,
  }) async {
    final result = await App.showBottomSheet(
      isScrollControlled: isScrollControlled,
      child: AppSelectBottomSheet<T>._(
        key: key,
        label: label,
        dataSource: dataSource,
        selectedItems: selectedItems,
        itemDisplay: itemDisplay,
        itemIdentity: itemIdentity,
        mode: _AppSelectBottomSheetMode.multiple,
        minTileHeight: minTileHeight,
        itemLeadingBuilder: itemLeadingBuilder,
        itemTrailingBuilder: itemTrailingBuilder,
        showSearchBar: showSearchBar,
      ),
    );

    return _parseMultipleResult<T>(result);
  }

  static Either<Null, T>? _parseSingleResult<T>(Object? result) {
    if (result == null) return null;

    if (result == _unselectedValue) {
      return const Left(null);
    }

    if (result is T) {
      return Right(result as T);
    }

    if (result is List<T> && result.isNotEmpty) {
      return Right(result.first);
    } else if (result is List<T> && result.isEmpty) {
      return const Left(null);
    }

    return null;
  }

  static Either<Null, List<T>>? _parseMultipleResult<T>(Object? result) {
    if (result == null) return null;

    if (result == _unselectedValue) {
      return const Left(null);
    }

    if (result is List<T> && result.isNotEmpty) {
      return Right(result);
    } else if (result is List<T> && result.isEmpty) {
      return const Left(null);
    }

    if (result is T) {
      return Right([result as T]);
    }

    return null;
  }

  final String label;

  /// Data source for loading items
  final AppSelectDataSource<T> dataSource;

  /// Selected items for multi select
  final List<T>? selectedItems;

  final _AppSelectBottomSheetMode mode;

  /// Item display function
  final AppSelectBottomSheetItemDisplay<T> itemDisplay;

  /// Item identity function for comparison
  final AppSelectBottomSheetItemIdentity<T> itemIdentity;

  final double minTileHeight;

  final AppSelectBottomSheetItemLeadingBuilder<T>? itemLeadingBuilder;
  final AppSelectBottomSheetItemTrailingBuilder<T>? itemTrailingBuilder;

  /// Whether to show search bar
  final bool showSearchBar;

  @override
  State<AppSelectBottomSheet<T>> createState() =>
      _AppSelectBottomSheetState<T>();
}

class _AppSelectBottomSheetState<T> extends State<AppSelectBottomSheet<T>> {
  final List<T> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    if (widget.mode == _AppSelectBottomSheetMode.single) {
      _selectedItems.clear();
      _selectedItems.addAll(widget.selectedItems ?? []);
    } else {
      _selectedItems.clear();
      _selectedItems.addAll(widget.selectedItems ?? []);
    }
  }

  void _onTap(T item, bool selected) {
    switch (widget.mode) {
      case _AppSelectBottomSheetMode.single:
        // Single select: confirm immediately on tap
        // If tapping on already selected item, unselect it (pop null)
        if (selected) {
          Navigator.of(context).pop(_unselectedValue);
        } else {
          Navigator.of(context).pop(item);
        }
        return;
      case _AppSelectBottomSheetMode.multiple:
        setState(() {
          if (selected) {
            _selectedItems.removeWhere((e) {
              return widget.itemIdentity(e) == widget.itemIdentity(item);
            });
          } else {
            _selectedItems.add(item);
          }
        });
    }
  }

  void _onConfirm(BuildContext context) {
    late final Object? result;

    switch (widget.mode) {
      case _AppSelectBottomSheetMode.single:
        result = _selectedItems.firstOrNull;
      case _AppSelectBottomSheetMode.multiple:
        result = _selectedItems.isEmpty ? _unselectedValue : _selectedItems;
    }

    Navigator.of(context).pop(result ?? _unselectedValue);
  }

  void _onReset(BuildContext context) {
    setState(() {
      switch (widget.mode) {
        case _AppSelectBottomSheetMode.single:
          _selectedItems.clear();
        case _AppSelectBottomSheetMode.multiple:
          _selectedItems.clear();
      }
    });
  }

  bool _isSelected(T item) {
    switch (widget.mode) {
      case _AppSelectBottomSheetMode.single:
        if (_selectedItems.isEmpty) return false;
        return widget.itemIdentity(_selectedItems.first) ==
            widget.itemIdentity(item);
      case _AppSelectBottomSheetMode.multiple:
        return _selectedItems.any(
          (selected) =>
              widget.itemIdentity(selected) == widget.itemIdentity(item),
        );
    }
  }

  double _getListBottomSafePadding(BuildContext context) {
    // Multiple select has a bottom bar which already applies SafeArea padding.
    // Single select has no bottom bar, so we pad the list to avoid overlapping
    // the system gesture area (home indicator).
    if (widget.mode == _AppSelectBottomSheetMode.multiple) return 0;
    return MediaQuery.paddingOf(context).bottom;
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      header: AppBottomSheetHeader(title: widget.label),
      content: Flexible(child: _buildList(context)),
      // Only show bottom bar for multiple select
      bottom: widget.mode == _AppSelectBottomSheetMode.multiple
          ? AppBottomSheetButton(child: _bottomBar(context))
          : null,
    );
  }

  Widget _buildList(BuildContext context) {
    return AppSelectPaginatedListView<T>(
      dataSource: widget.dataSource,
      itemDisplay: widget.itemDisplay,
      getItemIdentity: widget.itemIdentity,
      showSearchBar: widget.showSearchBar,
      padding: EdgeInsets.only(bottom: _getListBottomSafePadding(context)),
      itemBuilder: (context, item) {
        return AppSelectBottomSheetItem<T>(
          item: item,
          display: widget.itemDisplay,
          minTileHeight: widget.minTileHeight,
          selected: _isSelected(item),
          onTap: _onTap,
          leadingBuilder: widget.itemLeadingBuilder,
          trailingBuilder: widget.itemTrailingBuilder,
        );
      },
      separatorBuilder: _separatorBuilder,
    );
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    return const Divider(
      height: _kDefaultDividerHeight,
      color: AppColors.gray300,
      indent: AppSpacing.s2,
      endIndent: AppSpacing.s2,
    );
  }

  Widget _bottomBar(BuildContext context) {
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
            onPressed: () {
              _onReset(context);
            },
          ),
        ),
        Expanded(
          child: AppButton.filled(
            label: context.text(
              'core.bottomsheet.select_bottom_sheet.buttons.confirm',
              defaultValue: 'Hoàn tất',
            ),
            onPressed: () {
              _onConfirm(context);
            },
          ),
        ),
      ],
    );
  }
}

class AppSelectBottomSheetItem<T> extends StatelessWidget {
  const AppSelectBottomSheetItem({
    super.key,
    required this.item,
    required this.display,
    required this.selected,
    required this.onTap,
    required this.minTileHeight,
    this.leadingBuilder,
    this.trailingBuilder,
  });

  final T item;

  final double minTileHeight;

  final bool selected;

  final String Function(T item) display;

  final AppSelectBottomSheetItemLeadingBuilder<T>? leadingBuilder;

  final AppSelectBottomSheetItemTrailingBuilder<T>? trailingBuilder;

  final AppSelectBottomSheetItemOnTap<T> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: minTileHeight,
        child: ListTile(
          tileColor: Theme.of(context).colorScheme.surface,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4,
            vertical: 0,
          ),
          leading: leadingBuilder?.call(item, selected),
          title: AppText(
            display(item),
            style: AppFonts.size14Medium.copyWith(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            maxLines: null,
          ),
          trailing:
              trailingBuilder?.call(item, selected) ??
              (selected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null),
          onTap: () => onTap(item, selected),
        ),
      ),
    );
  }
}
