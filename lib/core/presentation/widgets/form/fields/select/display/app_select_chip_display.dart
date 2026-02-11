import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../theme/app_colors/app_colors.dart';
import '../../../../../../theme/app_fonts.dart';
import '../../../../../../theme/app_radius.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../app_text.dart';
import '../../../app_input_decoration.dart';
import '../select.dart';

class AppSelectChipDisplay<TValue, TItem>
    implements AppSelectDisplayStrategy<TValue, TItem> {
  const AppSelectChipDisplay({required this.itemDisplay, this.textStyle});

  final AppItemDisplay<TItem> itemDisplay;

  /// Optional text style (default: AppFonts.size14Regular).
  final TextStyle? textStyle;

  void _onTap({
    required BaseAppSelectFieldState<TValue, TItem> state,
    required TItem item,
    required bool selected,
  }) {
    if (state is AppMultiSelectFieldState) {
      if (selected) {
        (state as AppMultiSelectFieldState<TItem>).addItem(item);
      } else {
        (state as AppMultiSelectFieldState<TItem>).removeItem(item);
      }
    } else if (state is AppSingleSelectFieldState) {
      (state as AppSingleSelectFieldState<TItem>).updateValue(
        selected ? item : null,
      );
      state.control.markAsTouched();
    }
  }

  @override
  Widget build({required BaseAppSelectFieldState<TValue, TItem> state}) {
    final FormControl<TValue> control = state.control;
    final TValue? value = control.value;
    final bool enabled = control.enabled;
    final String? errorText = state.errorText;
    final AppSelectDataSource<TItem> dataSource = state.widget.dataSource;

    if (dataSource is AppSelectPaginatedDataSource) {
      throw UnimplementedError(
        '$AppSelectPaginatedDataSource is not supported',
      );
    } else {
      return _Field<TItem>(
        dataSource: dataSource,
        itemDisplay: itemDisplay,
        textStyle: textStyle,
        errorText: errorText,
        selected: value is List<TItem>
            ? value
            : value is TItem
            ? [value]
            : [],
        enabled: enabled,
        itemIdentity: state.widget.itemIdentity,
        onTap: (item, selected) =>
            _onTap(state: state, item: item, selected: selected),
      );
    }
  }
}

class _Field<TItem> extends StatefulWidget {
  const _Field({
    super.key,
    required this.dataSource,
    required this.itemDisplay,
    required this.errorText,
    required this.selected,
    required this.itemIdentity,
    required this.onTap,
    required this.enabled,
    required this.textStyle,
  });

  final AppSelectDataSource<TItem>? dataSource;

  final AppItemDisplay<TItem> itemDisplay;

  final String? errorText;

  final List<TItem> selected;

  final AppItemIdentity<TItem>? itemIdentity;

  final TextStyle? textStyle;

  final Function(TItem value, bool selected) onTap;

  final bool enabled;

  @override
  State<_Field<TItem>> createState() => __FieldState<TItem>();
}

class __FieldState<TItem> extends State<_Field<TItem>> {
  late final AppSelectDataSource<TItem>? dataSource;
  StreamSubscription? _dataSourceSubscription;

  final List<TItem> items = [];

  @override
  void initState() {
    super.initState();
    dataSource = widget.dataSource;
    items.clear();
    items.addAll(dataSource?.getCached()?.items ?? []);

    dataSource?.load().then((value) {
      items.clear();
      items.addAll(value.items);

      if (mounted) {
        setState(() {});
      }
    });

    _dataSourceSubscription = dataSource?.stream.listen((value) {
      items.clear();
      items.addAll(value.items);

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _dataSourceSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget content = IgnorePointer(
      ignoring: !widget.enabled,
      child: InputDecorator(
        decoration: AppInputDecoration.basic(
          errorText: widget.errorText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        child: Wrap(
          spacing: AppSpacing.s2,
          children:
              items.map((item) {
                final bool isSelected =
                    widget.itemIdentity != null
                        ? widget.selected.any(
                          (e) =>
                              widget.itemIdentity!(e) ==
                              widget.itemIdentity!(item),
                        )
                        : widget.selected.contains(item);

                return FilterChip(
                  label: AppText(widget.itemDisplay(item)),
                  labelStyle: (widget.textStyle ?? AppFonts.size14Medium)
                      .copyWith(
                        color: isSelected ? AppColors.white : AppColors.gray950,
                      ),
                  selected: isSelected,
                  onSelected: (selected) => widget.onTap(item, selected),
                  backgroundColor: AppColors.gray100,
                  selectedColor: AppColors.blue600,
                  showCheckmark: false,
                  elevation: 0,
                  pressElevation: 0,
                  side: BorderSide.none,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(AppRadius.full),
                  ),
                );
              }).toList(),
        ),
      ),
    );

    if (widget.enabled) {
      return content;
    }

    return Opacity(opacity: 0.5, child: content);
  }
}
