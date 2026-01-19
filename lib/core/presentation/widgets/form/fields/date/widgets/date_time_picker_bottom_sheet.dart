import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:template/app/app.dart';
import 'package:template/gen/locale_keys.gen.dart';

import '../../../../../../theme/app_colors/app_colors.dart';
import '../../../../../../theme/app_fonts.dart';
import '../../../../app_button/app_button.dart';
import '../../../../bottomsheet/app_bottom_sheet.dart';

enum DateTimePickerBottomSheetMode { date, time, dateTime }

class DateTimePickerBottomSheet extends StatefulWidget {
  const DateTimePickerBottomSheet._({
    this.title,
    this.value,
    this.mode = DateTimePickerBottomSheetMode.dateTime,
    this.minDate,
    this.maxDate,
    this.minuteInterval = 1,
  });

  final String? title;

  final DateTimePickerBottomSheetMode mode;

  final DateTime? value;

  final DateTime? minDate;

  final DateTime? maxDate;

  final int minuteInterval;

  static Future<DateTime?> show({
    String? title,
    DateTime? value,
    DateTimePickerBottomSheetMode mode = DateTimePickerBottomSheetMode.dateTime,
    DateTime? minDate,
    DateTime? maxDate,
    int minuteInterval = 1,
  }) async {
    final result = await App.showBottomSheet(
      child: DateTimePickerBottomSheet._(
        title: title,
        value: value,
        mode: mode,
        minDate: minDate,
        maxDate: maxDate,
        minuteInterval: minuteInterval,
      ),
    );

    if (result is DateTime) {
      return result;
    }

    return null;
  }

  @override
  State<DateTimePickerBottomSheet> createState() =>
      _DateTimePickerBottomSheetState();
}

class _DateTimePickerBottomSheetState extends State<DateTimePickerBottomSheet> {
  late DateTime value;
  late final DateTime? _minDate;
  late final DateTime? _maxDate;

  final double _pickerHeight = 180;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    value =
        widget.value ??
        DateTime(now.year, now.month, now.day, now.hour, now.minute);

    _minDate = widget.minDate != null
        ? _adjustValueWithMinuteInterval(widget.minDate!)
        : null;
    _maxDate = widget.maxDate != null
        ? _adjustValueWithMinuteInterval(widget.maxDate!)
        : null;

    _validateAndAdjustValue();
  }

  void _validateAndAdjustValue() {
    value = _adjustValueWithMinuteInterval(value);

    _validateDateRangeConstraints();

    if (widget.mode == DateTimePickerBottomSheetMode.time) {
      _validateTimeConstraints();
    }
  }

  DateTime _adjustValueWithMinuteInterval(DateTime value) {
    // Ensure minuteInterval is valid
    if (widget.minuteInterval <= 0 || 60 % widget.minuteInterval != 0) {
      return DateTime(
        value.year,
        value.month,
        value.day,
        value.hour,
        value.minute,
      );
    }

    // Format value according to minuteInterval
    final adjustedMinute =
        (value.minute / widget.minuteInterval).round() * widget.minuteInterval;
    return DateTime(
      value.year,
      value.month,
      value.day,
      value.hour,
      adjustedMinute,
      0,
    );
  }

  void _validateDateRangeConstraints() {
    // Ensure value is within adjusted min/max date range
    if (_minDate != null && value.isBefore(_minDate)) {
      value = _minDate;
    }
    if (_maxDate != null && value.isAfter(_maxDate)) {
      value = _maxDate;
    }
  }

  void _validateTimeConstraints() {
    // If minDate and maxDate are on the same day, ensure time is within range
    if (_minDate != null && _maxDate != null) {
      // If they're on the same day, validate time
      if (_minDate.year == _maxDate.year &&
          _minDate.month == _maxDate.month &&
          _minDate.day == _maxDate.day) {
        final currentTime = DateTime(2000, 1, 1, value.hour, value.minute);
        final minTime = DateTime(2000, 1, 1, _minDate.hour, _minDate.minute);
        final maxTime = DateTime(2000, 1, 1, _maxDate.hour, _maxDate.minute);

        if (currentTime.isBefore(minTime)) {
          value = DateTime(
            value.year,
            value.month,
            value.day,
            _minDate.hour,
            _minDate.minute,
          );
        } else if (currentTime.isAfter(maxTime)) {
          value = DateTime(
            value.year,
            value.month,
            value.day,
            _maxDate.hour,
            _maxDate.minute,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(
      header: AppBottomSheetHeader(
        title:
            widget.title ??
            switch (widget.mode) {
              DateTimePickerBottomSheetMode.date => context.text(
                LocaleKeys.core.bottomsheet.date_time_picker.title.date,
                defaultValue: 'Chọn ngày',
              ),
              DateTimePickerBottomSheetMode.time => context.text(
                LocaleKeys.core.bottomsheet.date_time_picker.title.time,
                defaultValue: 'Chọn thời gian',
              ),
              DateTimePickerBottomSheetMode.dateTime => context.text(
                LocaleKeys.core.bottomsheet.date_time_picker.title.date_time,
                defaultValue: 'Chọn ngày và thời gian',
              ),
            },
      ),
      bottom: AppBottomSheetButton(child: _applyButton(context)),
      content: CupertinoTheme(
        data: CupertinoTheme.of(context).copyWith(
          textTheme: CupertinoTheme.of(context).textTheme.copyWith(
            dateTimePickerTextStyle: AppFonts.size16Regular.copyWith(
              color: AppColors.gray800,
            ),
          ),
        ),
        child: switch (widget.mode) {
          DateTimePickerBottomSheetMode.date => CupertinoTheme(
            data: CupertinoTheme.of(context).copyWith(
              textTheme: CupertinoTheme.of(context).textTheme.copyWith(
                dateTimePickerTextStyle: AppFonts.size18Regular,
              ),
            ),
            child: _datePicker(),
          ),
          DateTimePickerBottomSheetMode.time => CupertinoTheme(
            data: CupertinoTheme.of(context).copyWith(
              textTheme: CupertinoTheme.of(context).textTheme.copyWith(
                dateTimePickerTextStyle: AppFonts.size18Regular,
              ),
            ),
            child: _timePicker(),
          ),
          DateTimePickerBottomSheetMode.dateTime => CupertinoTheme(
            data: CupertinoTheme.of(context).copyWith(
              textTheme: CupertinoTheme.of(context).textTheme.copyWith(
                dateTimePickerTextStyle: AppFonts.size16Regular,
              ),
            ),
            child: Row(
              children: [
                Expanded(flex: 2, child: _datePicker()),
                Expanded(child: _timePicker()),
              ],
            ),
          ),
        },
      ),
    );
  }

  Widget _datePicker() {
    return SizedBox(
      height: _pickerHeight,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.date,
        initialDateTime: value,
        minimumDate: _minDate,
        maximumDate: _maxDate,
        dateOrder: DatePickerDateOrder.dmy,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() {
            value = DateTime(
              newDateTime.year,
              newDateTime.month,
              newDateTime.day,
              value.hour,
              value.minute,
            );
            _validateAndAdjustValue();
          });
        },
      ),
    );
  }

  Widget _timePicker() {
    return SizedBox(
      height: _pickerHeight,
      child: CupertinoDatePicker(
        mode: CupertinoDatePickerMode.time,
        use24hFormat: true,
        initialDateTime: value,
        minimumDate: _minDate,
        maximumDate: _maxDate,
        minuteInterval: widget.minuteInterval,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() {
            value = DateTime(
              value.year,
              value.month,
              value.day,
              newDateTime.hour,
              newDateTime.minute,
            );
            _validateAndAdjustValue();
          });
        },
      ),
    );
  }

  Widget _applyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AppButton.filled(
        label: context.text('common.confirm', defaultValue: 'Xác nhận'),
        size: AppButtonSize.large,
        onPressed: () {
          context.pop(value);
        },
      ),
    );
  }
}
