import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../theme/app_fonts.dart';
import '../../../../app_icon.dart';
import '../../../app_input_decoration.dart';
import '../base/app_select_typedefs.dart';
import '../base/base_app_select_field.dart';
import 'app_select_display_strategy.dart';

/// TextField display strategy (default for single/multi select).
///
/// Renders a read-only TextField that displays selected value(s) as text.
/// Single select shows `itemDisplay(value)`, multi select shows comma-separated values.
class AppSelectTextFieldDisplay<TValue, TItem>
    implements AppSelectDisplayStrategy<TValue, TItem> {
  const AppSelectTextFieldDisplay({
    this.controller,
    required this.itemDisplay,
    this.textStyle,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
  });

  /// Optional text controller (will create new one if null).
  final TextEditingController? controller;

  /// Function to display an item as text.
  final AppItemDisplay<TItem> itemDisplay;

  /// Optional text style (default: AppFonts.size14Regular).
  final TextStyle? textStyle;

  /// Optional hint text (default: null).
  final String? hint;

  /// Optional prefix icon (default: null).
  final Widget? prefixIcon;

  /// Optional suffix icon (default: dropdown arrow).
  final Widget? suffixIcon;

  @override
  Widget build({required BaseAppSelectFieldState<TValue, TItem> state}) {
    final FormControl<TValue> control = state.control;
    final TValue? value = control.value;
    final bool enabled = control.enabled;
    final String? errorText = state.errorText;
    final VoidCallback onTap = state.handleFieldTap;

    // Calculate display text
    String displayText = '';
    if (value != null) {
      if (value is TItem) {
        // Single select
        displayText = itemDisplay(value as TItem);
      } else if (value is List<TItem>) {
        // Multi select
        displayText = value.map(itemDisplay).join(', ');
      }
    }

    // Create controller if not provided
    final effectiveController =
        controller ?? TextEditingController(text: displayText);

    // Update controller text if value changed
    if (controller == null && effectiveController.text != displayText) {
      effectiveController.text = displayText;
    }

    // Render TextField
    return TextField(
      controller: effectiveController,
      readOnly: true,
      enabled: enabled,
      style: textStyle ?? AppFonts.size14Regular,
      decoration: AppInputDecoration.basic(
        disabled: !enabled,
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon:
            suffixIcon ??
            const AppIcon(icon: Icons.keyboard_arrow_down_rounded, size: 18),
        errorText: errorText,
      ),
      onTap: enabled ? onTap : null,
    );
  }
}
