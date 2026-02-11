import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../theme/app_fonts.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../app_text.dart';
import '../base/app_select_typedefs.dart';
import '../base/base_app_select_field.dart';
import '../data_source/app_select_data_source.dart';
import '../data_source/app_select_paginated_data_source.dart';
import 'app_select_display_strategy.dart';

/// Radio button display strategy for single select fields.
/// Displays items as a vertical list of radio buttons.
class AppSelectRadioDisplay<TValue, TItem>
    implements AppSelectDisplayStrategy<TValue, TItem> {
  const AppSelectRadioDisplay({
    required this.itemDisplay,
    required this.itemValue,
    this.textStyle,
  });

  final TextStyle? textStyle;

  final AppItemDisplay<TItem> itemDisplay;

  final AppItemValue<TValue, TItem> itemValue;

  @override
  Widget build({required BaseAppSelectFieldState<TValue, TItem> state}) {
    final String? errorText = state.errorText;
    final AppSelectDataSource<TItem> dataSource = state.widget.dataSource;

    if (dataSource is AppSelectPaginatedDataSource) {
      throw UnimplementedError(
        '$AppSelectPaginatedDataSource is not supported for radio display',
      );
    }

    return _RadioField<TValue, TItem>(
      enabled: state.control.enabled,
      onChanged: (value) => state.control.updateValue(value),
      value: state.control.value,
      errorText: errorText,
      dataSource: dataSource,
      itemValue: itemValue,
      itemDisplay: itemDisplay,
    );
  }
}

class _RadioField<TValue, TItem> extends StatefulWidget {
  const _RadioField({
    super.key,
    required this.errorText,
    required this.dataSource,
    required this.itemValue,
    required this.itemDisplay,
    required this.enabled,
    required this.onChanged,
    required this.value,
    this.textStyle,
  });

  final String? errorText;

  final AppSelectDataSource<TItem> dataSource;

  final AppItemValue<TValue, TItem> itemValue;

  final AppItemDisplay<TItem> itemDisplay;

  final TextStyle? textStyle;

  final bool enabled;

  final void Function(TValue? value) onChanged;

  final TValue? value;

  @override
  State<_RadioField<TValue, TItem>> createState() =>
      _RadioFieldState<TValue, TItem>();
}

class _RadioFieldState<TValue, TItem>
    extends State<_RadioField<TValue, TItem>> {
  late final AppSelectDataSource<TItem> dataSource;
  final List<TItem> items = [];
  StreamSubscription? _dataSourceSubscription;

  @override
  void initState() {
    super.initState();
    dataSource = widget.dataSource;
    items.clear();
    items.addAll(dataSource.getCached()?.items ?? []);

    dataSource.load().then((value) {
      items.clear();
      items.addAll(value.items);

      if (mounted) {
        setState(() {});
      }
    });

    _dataSourceSubscription = dataSource.stream.listen((value) {
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
      child: RadioGroup<TValue>(
        groupValue: widget.value,
        onChanged: widget.onChanged,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: AppSpacing.s2,
          children:
              items
                  .map(
                    (item) => _RadioItem<TValue, TItem>(
                      item: item,
                      itemValue: widget.itemValue,
                      itemDisplay: widget.itemDisplay,
                      textStyle: widget.textStyle,
                      onChanged: widget.onChanged,
                    ),
                  )
                  .toList(),
        ),
      ),
    );

    if (widget.enabled) {
      return content;
    }

    return Opacity(opacity: 0.5, child: content);
  }
}

class _RadioItem<TValue, TItem> extends StatelessWidget {
  const _RadioItem({
    super.key,
    required this.item,
    required this.itemValue,
    required this.itemDisplay,
    required this.textStyle,
    required this.onChanged,
  });

  final TItem item;

  final AppItemValue<TValue, TItem> itemValue;

  final AppItemDisplay<TItem> itemDisplay;

  final TextStyle? textStyle;

  final void Function(TValue? value) onChanged;

  @override
  Widget build(BuildContext context) {
    final TValue value = itemValue(item);

    return GestureDetector(
      onTap: () => onChanged(value),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppSpacing.s2,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Radio<TValue>(
              key: Key(value.toString()),
              value: value,
              activeColor: Theme.of(context).colorScheme.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Expanded(
            child: AppText(
              itemDisplay(item),
              style: textStyle ?? AppFonts.size14Regular,
              maxLines: null,
              textAlign: TextAlign.start,
            ),
          ),
        ],
      ),
    );
  }
}
