import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class AppFormField<ModelDataType, ViewDataType>
    extends ReactiveFormField<ModelDataType, ViewDataType> {
  AppFormField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,
    super.focusNode,
    super.valueAccessor,
    required super.builder,
  });

  @override
  AppFormFieldState<ModelDataType, ViewDataType> createState();
}

abstract class AppFormFieldState<ModelDataType, ViewDataType>
    extends ReactiveFormFieldState<ModelDataType, ViewDataType> {
  late final ModelDataType? initialValue;

  late final FocusController focusController;

  @override
  FocusNode get focusNode => focusController.focusNode;

  @override
  void initState() {
    focusController = FocusController(
      focusNode: widget.focusNode ?? FocusNode(),
    );

    super.initState();

    initialValue = control.value;
  }

  @override
  void didChange(ViewDataType? value) {
    super.didChange(value);

    if (value != initialValue && control.pristine) {
      control.markAsDirty();
    } else if (value == initialValue && control.dirty) {
      control.markAsPristine();
    }
  }

  @override
  void subscribeControl() {
    control.registerFocusController(focusController);
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    control.unregisterFocusController(focusController);
    focusController.dispose();
    super.unsubscribeControl();
  }
}
