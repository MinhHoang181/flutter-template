import 'package:flutter/material.dart';

import '../base/base_app_select_field.dart';

/// Abstract display strategy for rendering selected value(s) in field.
///
/// Defines how selected values are displayed in the field UI. Use
/// [AppSelectTextFieldDisplay] for default text field display.
///
/// Generic parameters:
/// - [TValue]: FormControl value type (T? for single, List`<`T`>` for multi)
/// - [TItem]: Type of individual item
abstract class AppSelectDisplayStrategy<TValue, TItem> {
  /// Build widget to display field with selected value.
  Widget build({required BaseAppSelectFieldState<TValue, TItem> state});
}
