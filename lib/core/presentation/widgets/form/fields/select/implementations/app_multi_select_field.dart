import 'package:core_extension/core_extension.dart';
import 'package:flutter/material.dart';

import '../../../app_form_field_builder.dart';
import '../base/base_app_select_field.dart';
import '../data_source/app_select_data_source.dart';

/// Multi select field for selecting multiple items from a list.
///
/// Integrates with reactive_forms and supports various data sources,
/// display strategies, and popup strategies.
///
/// FormControl value type is `List<T>`. Empty list `[]` represents no selection.
class AppMultiSelectField<T> extends BaseAppSelectField<List<T>, T> {
  AppMultiSelectField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    super.focusNode,
    required super.itemIdentity,
    super.dataSource = const AppSelectDataSource.empty(),
    required super.displayStrategy,
    required super.popupStrategy,
    this.label,
  });

  /// Optional label displayed above the field.
  final String? label;

  @override
  BaseAppSelectFieldState<List<T>, T> createState() =>
      AppMultiSelectFieldState<T>();
}

class AppMultiSelectFieldState<T> extends BaseAppSelectFieldState<List<T>, T> {
  @override
  AppMultiSelectField<T> get widget => super.widget as AppMultiSelectField<T>;

  /// Update value and notify form control.
  void updateValue(List<T> value) => didChange(value);

  /// Remove item from selected list.
  ///
  /// Uses [itemIdentity] to find and remove the item.
  void removeItem(T item) {
    final current = value ?? [];
    final updated = current
        .where((i) => widget.itemIdentity(i) != widget.itemIdentity(item))
        .toList();
    didChange(updated);
  }

  /// Add item to selected list (with duplicate check).
  ///
  /// Uses [itemIdentity] to check for duplicates.
  void addItem(T item) {
    final current = value ?? [];
    // Check if item already exists using identity
    final itemId = widget.itemIdentity(item);
    final exists = current.any((i) => widget.itemIdentity(i) == itemId);
    if (!exists) {
      didChange([...current, item]);
    }
  }

  @override
  Widget buildFieldDisplay() {
    final field = widget.displayStrategy.build(state: this);

    // Wrap with label if provided
    if (widget.label != null) {
      return AppFormFieldBuilder(
        label: widget.label.validate(),
        formControl: control,
        field: field,
      );
    }

    return field;
  }

  @override
  Future<List<T>?>? showSelectionPopup() {
    return widget.popupStrategy?.show(
      context,
      state: this,
      dataSource: widget.dataSource,
      displayStrategy: widget.displayStrategy,
    );
  }
}
