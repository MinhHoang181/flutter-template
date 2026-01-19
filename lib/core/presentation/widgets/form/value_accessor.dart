import 'package:core_extension/core_extension.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CurrencyValueAccessor extends ControlValueAccessor<double, String> {
  CurrencyValueAccessor({required this.currencyFormatter});

  final CurrencyTextInputFormatter currencyFormatter;

  @override
  String modelToViewValue(double? modelValue) {
    return currencyFormatter.formatDouble(modelValue ?? 0);
  }

  @override
  double? viewToModelValue(String? viewValue) {
    return currencyFormatter.getDouble();
  }
}

class AppDateValueAccessor extends ControlValueAccessor<DateTime, String> {
  AppDateValueAccessor({this.format = 'dd/MM/yyyy', this.customFormat});

  final String format;

  final String? Function(DateTime? date)? customFormat;

  @override
  String modelToViewValue(DateTime? modelValue) {
    return customFormat?.call(modelValue) ??
        modelValue.showDate(format: format);
  }

  @override
  DateTime? viewToModelValue(String? viewValue) {
    return viewValue.toDateOrNull();
  }
}
