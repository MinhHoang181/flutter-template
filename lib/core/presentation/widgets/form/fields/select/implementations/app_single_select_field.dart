import 'package:core_extension/core_extension.dart';
import 'package:flutter/material.dart';

import '../../../app_form_field_builder.dart';
import '../base/base_app_select_field.dart';
import '../data_source/app_select_data_source.dart';

/// Single select field for selecting one item from a list.
///
/// Integrates with reactive_forms and supports various data sources,
/// display strategies, and popup strategies.
class AppSingleSelectField<T> extends BaseAppSelectField<T, T> {
  AppSingleSelectField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    super.focusNode,
    required super.itemIdentity,
    super.dataSource = const AppSelectDataSource.empty(),
    required super.displayStrategy,
    super.popupStrategy,
    this.label,
  });

  /// Optional label displayed above the field.
  final String? label;

  @override
  BaseAppSelectFieldState<T, T> createState() => AppSingleSelectFieldState<T>();
}

class AppSingleSelectFieldState<T> extends BaseAppSelectFieldState<T, T> {
  @override
  AppSingleSelectField<T> get widget => super.widget as AppSingleSelectField<T>;

  /// Update value and notify form control
  void updateValue(T? value) => didChange(value);

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
  Future<T?>? showSelectionPopup() {
    return widget.popupStrategy?.show(
      context,
      state: this,
      dataSource: widget.dataSource,
      displayStrategy: widget.displayStrategy,
    );
  }
}
