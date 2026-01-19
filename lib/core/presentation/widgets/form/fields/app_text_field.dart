import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../theme/app_fonts.dart';
import '../app_form_field.dart';
import '../app_form_field_builder.dart';
import '../app_input_decoration.dart';

class AppTextField<T> extends AppFormField<T, String> {
  AppTextField({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    required this.label,
    this.hint,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.suffixIcon,
    this.prefixIcon,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autocorect = true,
    this.enableSuggestions = true,
    this.autofillHints = const <String>[],
    this.inputFormatters,
    this.obscureText = false,
    this.obscuringCharacter = '•',
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.onEditingComplete,
    this.textController,
    this.scrollController,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.groupId = EditableText,
    ReactiveFormFieldBuilder<T, String>? builder,
  }) : super(
         builder:
             builder ??
             (field) {
               final AppTextFieldState state = field as AppTextFieldState;

               return AppFormFieldBuilder(
                 label: label,
                 formControl: state.control,
                 field: state.field(),
               );
             },
       );

  final Object groupId;

  // decoration
  final String label;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EditableTextContextMenuBuilder? contextMenuBuilder;

  // keyboard
  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool autocorect;
  final bool enableSuggestions;
  final Iterable<String> autofillHints;

  // format
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final String obscuringCharacter;

  // callbacks
  final ReactiveFormFieldCallback<T>? onTap;
  final ReactiveFormFieldCallback<T>? onChanged;
  final ReactiveFormFieldCallback<T>? onSubmitted;
  final ReactiveFormFieldCallback<T>? onEditingComplete;

  // controller
  final TextEditingController? textController;
  final ScrollController? scrollController;

  @override
  AppFormFieldState<T, String> createState() => AppTextFieldState<T>();

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }
}

class AppTextFieldState<T> extends AppFormFieldState<T, String> {
  @override
  AppTextField<T> get widget => super.widget as AppTextField<T>;

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _initializeTextController();
  }

  @override
  void dispose() {
    if (widget.textController == null) {
      _textController.dispose();
    }

    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  void _initializeTextController() {
    _textController = (widget.textController != null)
        ? widget.textController!
        : TextEditingController();
    _textController.text = initialValue == null ? '' : initialValue.toString();
  }

  @override
  ControlValueAccessor<T, String> selectValueAccessor() {
    if (widget.valueAccessor != null) {
      return widget.valueAccessor!;
    }

    if (control is FormControl<int>) {
      return IntValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<double>) {
      return DoubleValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<DateTime>) {
      return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<TimeOfDay>) {
      return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
    }

    return super.selectValueAccessor();
  }

  Widget field({bool? obscureText, Widget? suffixIcon, Widget? prefixIcon}) {
    return TextField(
      groupId: widget.groupId,
      enabled: control.enabled,
      // controller
      controller: _textController,
      scrollController: widget.scrollController,
      // decoration
      style: AppFonts.size14Regular,
      decoration: AppInputDecoration.basic(
        disabled: control.disabled,
        hintText: widget.hint,
        suffixIcon: suffixIcon ?? widget.suffixIcon,
        prefixIcon: prefixIcon ?? widget.prefixIcon,
        errorText: errorText,
      ),
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLength: widget.maxLength,
      contextMenuBuilder: widget.contextMenuBuilder,
      // keyboard
      focusNode: focusNode,
      autofocus: widget.autofocus,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      autocorrect: widget.autocorect,
      enableSuggestions: widget.enableSuggestions,
      autofillHints: widget.autofillHints,
      // format
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      obscureText: obscureText ?? widget.obscureText,
      obscuringCharacter: widget.obscuringCharacter,
      // callbacks
      onTap: widget.onTap != null ? () => widget.onTap?.call(control) : null,
      onChanged: (value) {
        didChange(value);
        widget.onChanged?.call(control);
      },
      onSubmitted: widget.onSubmitted != null
          ? (_) => widget.onSubmitted?.call(control)
          : null,
      onEditingComplete: widget.onEditingComplete != null
          ? () => widget.onEditingComplete?.call(control)
          : null,
    );
  }
}
