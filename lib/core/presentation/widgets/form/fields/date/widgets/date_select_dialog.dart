import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:template/app/app.dart';
import 'package:template/gen/locale_keys.gen.dart';

import '../../../../../../theme/app_fonts.dart';
import '../../../../../../theme/app_radius.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../app_button/app_button.dart';

enum _AppDatePickerDialogMode { single, multiple, range }

class DateSelectDialog extends StatefulWidget {
  const DateSelectDialog._({
    super.key,
    this.minDate,
    this.maxDate,
    this.mode = _AppDatePickerDialogMode.single,
    this.initialSelectedDates,
  });

  static Future<DateTime?> showSingle({
    Key? key,
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? initialDate,
  }) async {
    final result = await App.showDialog(
      child: DateSelectDialog._(
        key: key,
        minDate: minDate,
        maxDate: maxDate,
        initialSelectedDates: initialDate != null ? [initialDate] : null,
        mode: _AppDatePickerDialogMode.single,
      ),
    );

    if (result == null) return null;

    if (result is List<DateTime>) {
      return result.firstOrNull;
    }

    if (result is DateTime) {
      return result;
    }

    return null;
  }

  static Future<List<DateTime>?> showMultiple({
    Key? key,
    DateTime? minDate,
    DateTime? maxDate,
    List<DateTime>? initialSelectedDates,
  }) async {
    final result = await App.showDialog(
      child: DateSelectDialog._(
        key: key,
        minDate: minDate,
        maxDate: maxDate,
        initialSelectedDates: initialSelectedDates,
        mode: _AppDatePickerDialogMode.multiple,
      ),
    );

    if (result == null) return null;

    if (result is List<DateTime>) {
      return result;
    }

    if (result is DateTime) {
      return [result];
    }

    return null;
  }

  static Future<(DateTime? minDate, DateTime? maxDate)?> showRange({
    Key? key,
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? initialMinDate,
    DateTime? initialMaxDate,
  }) async {
    final result = await App.showDialog(
      child: DateSelectDialog._(
        key: key,
        minDate: minDate,
        maxDate: maxDate,
        initialSelectedDates: [
          if (initialMinDate != null) initialMinDate,
          if (initialMaxDate != null) initialMaxDate,
        ],
        mode: _AppDatePickerDialogMode.range,
      ),
    );

    if (result == null) return null;

    if (result is List<DateTime>) {
      return (result.firstOrNull, result.lastOrNull);
    }

    if (result is DateTime) {
      return (result, result);
    }

    if (result is (DateTime?, DateTime?)) {
      return result;
    }

    return null;
  }

  final DateTime? minDate;

  final DateTime? maxDate;

  final List<DateTime>? initialSelectedDates;

  final _AppDatePickerDialogMode mode;

  @override
  State<DateSelectDialog> createState() => _DateSelectDialogState();
}

class _DateSelectDialogState extends State<DateSelectDialog> {
  final List<DateTime> _dates = [];

  @override
  void initState() {
    super.initState();

    if (widget.initialSelectedDates != null) {
      _dates.addAll(widget.initialSelectedDates!);
    }
  }

  void _onConfirm(BuildContext context) {
    late final Object? result;

    switch (widget.mode) {
      case _AppDatePickerDialogMode.single:
        result = _dates.firstOrNull;
      case _AppDatePickerDialogMode.multiple:
        result = _dates;
      case _AppDatePickerDialogMode.range:
        result = (_dates.firstOrNull, _dates.lastOrNull);
    }
    Navigator.of(context).pop(result);
  }

  void _onReset(BuildContext context) {
    _dates.clear();

    if (mounted) {
      setState(() {});
    }
  }

  void _onValueChanged(List<DateTime> dates) {
    _dates.clear();
    _dates.addAll(dates);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s4,
        vertical: AppSpacing.s4,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(AppRadius.xxxl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _contentBuilder(context),
            const SizedBox(height: 16),
            _buttonBuilder(context),
          ],
        ),
      ),
    );
  }

  Widget _contentBuilder(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: switch (widget.mode) {
          _AppDatePickerDialogMode.single => CalendarDatePicker2Type.single,
          _AppDatePickerDialogMode.multiple => CalendarDatePicker2Type.multi,
          _AppDatePickerDialogMode.range => CalendarDatePicker2Type.range,
        },
        firstDate: widget.minDate,
        lastDate: widget.maxDate,
        calendarViewMode: CalendarDatePicker2Mode.day,
        firstDayOfWeek: DateTime.monday,
        weekdayLabelTextStyle: AppFonts.size14Semi,
        dayTextStyle: AppFonts.size14Regular,
        controlsTextStyle: AppFonts.size14Semi,
        selectedDayHighlightColor: Theme.of(context).colorScheme.primary,
      ),
      value: _dates,
      onValueChanged: _onValueChanged,
    );
  }

  Widget _buttonBuilder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: AppSpacing.s4,
      children: [
        Expanded(
          child: AppButton.filled(
            style: AppFilledButtonStyle.secondary,
            onPressed: () {
              _onReset(context);
            },
            label: context.text(
              LocaleKeys.core.dialog.date_picker.buttons.reset,
              defaultValue: 'Đặt lại',
            ),
          ),
        ),
        Expanded(
          child: AppButton.filled(
            onPressed: () {
              _onConfirm(context);
            },
            label: context.text(
              LocaleKeys.core.dialog.date_picker.buttons.done,
              defaultValue: 'Hoàn tất',
            ),
          ),
        ),
      ],
    );
  }
}
