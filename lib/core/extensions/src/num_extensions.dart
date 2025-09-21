part of '../extensions.dart';

/// Number check extension
extension NumberCheckExt on num? {
  /// Check if the number is null or zero.
  bool get isZeroOrNull {
    if (this == null) return true;
    if (this! == 0) return true;

    return false;
  }

  /// Check if the number is not null and not zero.
  bool get isNotZeroAndNull => !isZeroOrNull;

  /// Check if the number is even.
  bool get isEven {
    if (this == null) return false;

    return this! % 2 == 0;
  }

  /// Check if the number is odd.
  bool get isOdd {
    if (this == null) return false;

    return this! % 2 != 0;
  }
}

/// Number convert extension
extension NumberConvertExt on num? {
  /// Converts file size to human readable format.
  String toFileSize({bool base1024 = true, int beginUnit = 0, String format = '#,##0.#'}) {
    if (this == null) return '0';
    if (this! <= 0) return '0';

    final base = base1024 ? 1024 : 1000;

    final units = ['B', 'kB', 'MB', 'GB', 'TB'];
    final int digitGroups = (log(this!) / log(base)).round();

    return '${NumberFormat(format).format(this! / pow(base, digitGroups))} ${units[digitGroups + beginUnit]}';
  }

  /// Converts num to date time or null.
  DateTime? toDateTimeOrNull({bool isUtc = false}) {
    if (this == null) return null;

    const int minEpochValue = 0; // Epoch start
    final int maxEpochValueInSeconds =
        DateTime.now().add(const Duration(days: 365 * 50)).millisecondsSinceEpoch ~/ 1000;
    final int maxEpochValueInMilliseconds = maxEpochValueInSeconds * 1000;
    final int maxEpochValueInMicroseconds = maxEpochValueInMilliseconds * 1000;

    if (this! >= minEpochValue) {
      if (this! <= maxEpochValueInSeconds) {
        // Likely in seconds
        return DateTime.fromMillisecondsSinceEpoch(this!.toInt() * 1000, isUtc: isUtc);
      } else if (this! <= maxEpochValueInMilliseconds) {
        // Likely in milliseconds
        return DateTime.fromMillisecondsSinceEpoch(this!.toInt(), isUtc: isUtc);
      } else if (this! <= maxEpochValueInMicroseconds) {
        // Likely in microseconds
        return DateTime.fromMicrosecondsSinceEpoch(this!.toInt(), isUtc: isUtc);
      }
    }

    return null; // Not a valid timestamp or out of expected range
  }

  /// Converts num to date time or default value.
  DateTime toDateTime({required DateTime defaultValue, bool isUtc = false}) {
    return toDateTimeOrNull(isUtc: isUtc) ?? defaultValue;
  }
}

/// Int format extension.
extension IntFormatExt on int? {
  /// Converts data to int or default value.
  int validate({int defaultValue = 0}) {
    return this ?? defaultValue;
  }
}

/// Double format extension.
extension DoubleFormatExt on double? {
  /// Converts data to double or default value.
  double validate({double defaultValue = 0.0}) {
    return this ?? defaultValue;
  }
}

/// Number format extension.
extension NumberFormatExt on num? {
  /// degree to radian.
  double? get degreeToRadian {
    if (this == null) return null;

    return this! * pi / 180;
  }

  /// radian to degree.
  double? get radianToDegree {
    if (this == null) return null;

    return this! * 180 / pi;
  }
}
