import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../app_icon.dart';
import '../../app_form_field.dart';
import '../../app_form_field_builder.dart';
import '../../app_input_decoration.dart';
import 'popup/app_date_dialog_popup.dart';
import 'popup/app_date_popup_strategy.dart';

class AppDateField extends AppFormField<DateTime, DateTime> {
  AppDateField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    super.focusNode,
    required this.label,
    this.hint,
    this.initialDate,
    this.minDate,
    this.maxDate,
    this.onSelect,
    this.dateAccessor,
    this.popupStrategy = const AppDateDialogPopup(),
    this.prefixIcon,
    ReactiveFormFieldBuilder<DateTime, DateTime>? builder,
  }) : super(
         builder:
             builder ??
             (field) {
               final AppDateFieldState state = field as AppDateFieldState;

               return AppFormFieldBuilder(
                 label: label,
                 formControl: state.control,
                 field: state.field(),
               );
             },
       );

  // decoration
  final String label;
  final String? hint;

  final DateTime? initialDate;

  final DateTime? minDate;

  final DateTime? maxDate;

  final ReactiveFormFieldCallback<DateTime>? onSelect;

  final ControlValueAccessor<DateTime, String>? dateAccessor;

  /// Popup strategy for showing the date picker.
  /// Defaults to [AppDateDialogPopup].
  /// Use [AppDateTimeBottomSheetPopup] for bottom sheet picker with time.
  final AppDatePopupStrategy popupStrategy;

  /// Optional prefix icon (default: calendar icon).
  final Widget? prefixIcon;

  @override
  AppFormFieldState<DateTime, DateTime> createState() => AppDateFieldState();
}

class AppDateFieldState extends AppFormFieldState<DateTime, DateTime> {
  @override
  AppDateField get widget => super.widget as AppDateField;

  Future<void> _onPickDate() async {
    final result = await widget.popupStrategy.show(
      context,
      currentValue: control.value,
      initialDate: widget.initialDate,
      minDate: widget.minDate,
      maxDate: widget.maxDate,
    );

    if (result != null) {
      didChange(result);
      widget.onSelect?.call(control);
    }
  }

  Widget field() {
    return ReactiveTextField<DateTime>(
      formControl: control,
      valueAccessor:
          widget.dateAccessor ??
          DateTimeValueAccessor(dateTimeFormat: DateFormat('dd/MM/yyyy')),
      readOnly: true,
      decoration: AppInputDecoration.basic(
        disabled: control.disabled,
        hintText: widget.hint,
        prefixIcon:
            widget.prefixIcon ??
            const AppIcon(icon: Icons.calendar_month_rounded, size: 18),
        errorText: errorText,
      ),
      onTap: control.enabled ? (_) => _onPickDate() : null,
    );
  }
}
