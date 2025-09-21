part of '../extensions.dart';

/// DateTime check extension
extension DateTimeCheckExt on DateTime? {
  /// Check if the date is same as the given date
  bool isSameDate(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;

    return this!.year == date.year && this!.month == date.month && this!.day == date.day;
  }

  /// Check if the date is yesterday of the given date
  bool isYesterday(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;

    final DateTime yesterday = date.subtract(const Duration(days: 1));
    return isSameDate(yesterday);
  }

  /// Check if the date is tomorrow of the given date
  bool isTomorrow(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;

    final DateTime tomorrow = date.add(const Duration(days: 1));
    return isSameDate(tomorrow);
  }

  /// Check if the date is same week as the given date
  bool isSameWeek(DateTime? date) {
    if (this == null) return false;
    if (date == null) return false;
    if (isSameDate(date)) return true;

    final int weekDayDifference = this!.weekday - DateTime.monday;
    final DateTime startOfWeek = this!.subtract(Duration(days: weekDayDifference));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    if (date.isSameDate(startOfWeek)) return true;
    if (date.isSameDate(endOfWeek)) return true;

    return date.isAfter(startOfWeek) && date.isBefore(endOfWeek);
  }

  /// Check if the date is weekend
  bool get isWeekend {
    if (this == null) return false;
    return this!.weekday == DateTime.saturday || this!.weekday == DateTime.sunday;
  }

  /// Check if the date is weekday
  bool get isWeekday {
    if (this == null) return false;
    return !isWeekend;
  }
}

/// DateTime convert extension
extension DateTimeConvertExt on DateTime? {
  /// Convert DateTime to formatted string
  ///
  /// [format] is the format of the date.
  String showDate({String format = 'dd/MM/yyyy'}) {
    if (this == null) {
      return '';
    }
    return DateFormat(format).format(this!);
  }

  /// Get days in month
  int get daysInMonth {
    if (this == null) return 0;

    final DateTime beginningNextMonth = (this!.month < 12)
        ? DateTime(this!.year, this!.month + 1, 1)
        : DateTime(this!.year + 1, 1, 1);

    return beginningNextMonth.subtract(const Duration(days: 1)).day;
  }
}

/// DateTime format extensions
extension DateTimeFormatExt on DateTime {
  /// Convert to DateTime (Date only)
  DateTime toDate() {
    return DateTime(year, month, day);
  }

  /// Converts to DateTime (Time only)
  ///
  /// [second] show second, default is false
  ///
  /// [millisecond] show millisecond, default is false
  ///
  /// [microsecond] show microsecond, default is false
  DateTime toTime({bool second = false, bool millisecond = false, bool microsecond = false}) {
    return DateTime(
      0,
      0,
      0,
      hour,
      minute,
      second ? this.second : 0,
      millisecond ? this.millisecond : 0,
      microsecond ? this.microsecond : 0,
    );
  }

  /// Get first day of month
  DateTime get firstDayOfMonth {
    return DateTime(year, month, 1);
  }

  /// Get last day of month
  DateTime get lastDayOfMonth {
    return DateTime(year, month + 1, 0);
  }

  /// Get first day of week
  DateTime get firstDayOfWeek {
    return subtract(Duration(days: weekday - DateTime.monday));
  }

  /// Get last day of week
  DateTime get lastDayOfWeek {
    return add(Duration(days: DateTime.sunday - weekday));
  }
}

/// Nullable DateTime format extensions
extension NullableDateTimeFormatExt on DateTime? {
  /// Validate DateTime or return default value
  ///
  /// [defaultValue] is the default value to return if the DateTime is null.
  DateTime validate({required DateTime defaultValue}) {
    return this ?? defaultValue;
  }

  /// Convert to DateTime (Date only) or null
  DateTime? toDateOrNull() {
    if (this == null) return null;

    return this!.toDate();
  }

  /// Convert to DateTime (Date only) or default value
  ///
  /// [defaultValue] is the default value to return if the DateTime is null.
  DateTime toDate({required DateTime defaultValue}) {
    return toDateOrNull() ?? DateTime(defaultValue.year, defaultValue.month, defaultValue.day);
  }

  /// Converts to DateTime (Time only) or null.
  ///
  /// [second] show second, default is false
  ///
  /// [millisecond] show millisecond, default is false
  ///
  /// [microsecond] show microsecond, default is false
  DateTime? toTimeOrNull({bool second = false, bool millisecond = false, bool microsecond = false}) {
    if (this == null) return null;
    return this!.toTime(second: second, millisecond: millisecond, microsecond: microsecond);
  }

  /// Converts to DateTime (Time only) or default value.
  ///
  /// [defaultValue] is the default value to return if the DateTime is null.
  ///
  /// [second] show second, default is false
  ///
  /// [millisecond] show millisecond, default is false
  ///
  /// [microsecond] show microsecond, default is false
  DateTime toTime({
    required DateTime defaultValue,
    bool second = false,
    bool millisecond = false,
    bool microsecond = false,
  }) {
    return toTimeOrNull() ??
        DateTime(
          0,
          0,
          0,
          defaultValue.hour,
          defaultValue.minute,
          second ? defaultValue.second : 0,
          millisecond ? defaultValue.millisecond : 0,
          microsecond ? defaultValue.microsecond : 0,
        );
  }

  /// Get first day of month
  DateTime? get firstDayOfMonth {
    if (this == null) return null;

    return this!.firstDayOfMonth;
  }

  /// Get last day of month
  DateTime? get lastDayOfMonth {
    if (this == null) return null;

    return this!.lastDayOfMonth;
  }

  /// Get first day of week
  DateTime? get firstDayOfWeek {
    if (this == null) return null;

    return this!.firstDayOfWeek;
  }

  /// Get last day of week
  DateTime? get lastDayOfWeek {
    if (this == null) return null;

    return this!.lastDayOfWeek;
  }
}
