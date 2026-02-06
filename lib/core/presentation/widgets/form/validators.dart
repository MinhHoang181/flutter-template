import 'package:core_extension/core_extension.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:template/app/app.dart';
import 'package:template/gen/locale_keys.gen.dart';

class AppValidators {
  AppValidators._();

  static Map<String, String Function(Object)> validationMessages = {
    '$Exception': (error) => error.toString(),
    AppRequiredValidator.required: (error) => error.toString(),
    AppEmailValidator.invalid: (error) => error.toString(),
    AppPhoneValidator.invalid: (error) => error.toString(),
    AppDateOfBirthValidator.futureDate: (error) => error.toString(),
    AppDateOfBirthValidator.tooOld: (error) => error.toString(),
    AppNationalIdValidator.invalid: (error) => error.toString(),
    AppNumCompareValidator.lessThanMin: (error) => error.toString(),
    AppNumCompareValidator.greaterThanMax: (error) => error.toString(),
    AppNumCompareValidator.notEqual: (error) => error.toString(),
    AppIterableLengthValidator.lessThanMin: (error) => error.toString(),
    AppIterableLengthValidator.greaterThanMax: (error) => error.toString(),
    AppOtpValidator.invalid: (error) => error.toString(),
    AppPasswordValidator.lessThanMin: (error) => error.toString(),
    AppPasswordValidator.noNumber: (error) => error.toString(),
    AppConfirmPasswordValidator.notMatch: (error) => error.toString(),
    AppDateValidator.lessThanMin: (error) => error.toString(),
    AppDateValidator.greaterThanMax: (error) => error.toString(),
  };
}

class AppRequiredValidator extends RequiredValidator {
  const AppRequiredValidator();

  static String required = '$AppRequiredValidator.required';

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final String errorMessage = App.text(
      LocaleKeys.core.validate.is_required,
      defaultValue: 'Vui lòng nhập dữ liệu',
    );

    final value = control.value;

    if (value == null) {
      return {required: errorMessage};
    }

    if (value is String && value.isEmpty) {
      return {required: errorMessage};
    }

    return null;
  }
}

class AppDateOfBirthValidator extends Validator<DateTime?> {
  const AppDateOfBirthValidator();

  static String futureDate = '$AppDateOfBirthValidator.future_date';
  static String tooOld = '$AppDateOfBirthValidator.too_old';

  @override
  Map<String, dynamic>? validate(AbstractControl<DateTime?> control) {
    final value = control.value;
    if (value == null) return null;

    final now = DateTime.now();

    // Check future date
    if (value.isAfter(now)) {
      return {
        futureDate: App.text(
          LocaleKeys.core.validate.date_of_birth.future_date,
          defaultValue: 'Ngày sinh không thể ở tương lai',
        ),
      };
    }

    // Check too old
    if (value.isBefore(DateTime(now.year - 100, now.month, now.day))) {
      return {
        tooOld: App.text(
          LocaleKeys.core.validate.date_of_birth.too_old,
          defaultValue: 'Ngày sinh không hợp lệ (quá xa quá khứ)',
        ),
      };
    }

    return null;
  }
}

class AppEmailValidator extends Validator<String?> {
  const AppEmailValidator();

  static String invalid = '$AppEmailValidator.invalid';

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (!value.isEmail) {
      return {
        invalid: App.text(
          LocaleKeys.core.validate.email.invalid,
          defaultValue: 'Email không hợp lệ',
        ),
      };
    }

    return null;
  }
}

class AppPhoneValidator extends Validator<String?> {
  const AppPhoneValidator();

  static String invalid = '$AppPhoneValidator.invalid';

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (!value.isPhone) {
      return {
        invalid: App.text(
          LocaleKeys.core.validate.phone.invalid,
          defaultValue: 'Số điện thoại không hợp lệ',
        ),
      };
    }

    return null;
  }
}

class AppNationalIdValidator extends Validator<String?> {
  const AppNationalIdValidator();

  static String invalid = '$AppNationalIdValidator.invalid';

  static final RegExp _nationalIdRegex = RegExp(
    r'^[A-Za-z0-9](?:[A-Za-z0-9\/\-\s]{4,18})[A-Za-z0-9]$',
  );

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (!_nationalIdRegex.hasMatch(value)) {
      return {
        invalid: App.text(
          LocaleKeys.core.validate.national_id.invalid,
          defaultValue: 'Mã không hợp lệ',
        ),
      };
    }

    return null;
  }
}

class AppNumCompareValidator extends Validator<num?> {
  const AppNumCompareValidator({this.min, this.max, this.equal});

  static String notEqual = '$AppNumCompareValidator.not_equal';
  static String lessThanMin = '$AppNumCompareValidator.less_than_min';
  static String greaterThanMax = '$AppNumCompareValidator.greater_than_max';

  final num? min;

  final num? max;

  final num? equal;

  @override
  Map<String, dynamic>? validate(AbstractControl<num?> control) {
    final num? value = control.value;

    if (value == null) return null;

    if (equal != null && value != equal!) {
      return {
        notEqual: App.text(
          LocaleKeys.core.validate.num_compare.not_equal,
          defaultValue: 'Giá trị phải không bằng {equal}'.replaceFirst(
            '{equal}',
            equal.toString(),
          ),
          namedArgs: {'equal': equal.toString()},
        ),
      };
    }

    if (min != null && value < min!) {
      return {
        lessThanMin: App.text(
          LocaleKeys.core.validate.num_compare.less_than_min,
          defaultValue: 'Giá trị phải lớn hơn hoặc bằng {min}'.replaceFirst(
            '{min}',
            min.toString(),
          ),
          namedArgs: {'min': min.toString()},
        ),
      };
    }

    if (max != null && value > max!) {
      return {
        greaterThanMax: App.text(
          LocaleKeys.core.validate.num_compare.greater_than_max,
          defaultValue: 'Giá trị phải nhỏ hơn hoặc bằng {max}'.replaceFirst(
            '{max}',
            max.toString(),
          ),
          namedArgs: {'max': max.toString()},
        ),
      };
    }

    return null;
  }
}

class AppIterableLengthValidator extends Validator<Iterable?> {
  const AppIterableLengthValidator({this.min, this.max});

  static String lessThanMin = '$AppIterableLengthValidator.less_than_min';
  static String greaterThanMax = '$AppIterableLengthValidator.greater_than_max';

  final int? min;

  final int? max;

  @override
  Map<String, dynamic>? validate(AbstractControl<Iterable?> control) {
    final Iterable? value = control.value;

    if (value == null) return null;

    if (min != null && value.length < min!) {
      return {
        lessThanMin: App.text(
          LocaleKeys.core.validate.iterable_length.less_than_min,
          defaultValue: 'Số lượng phải lớn hơn hoặc bằng {min}'.replaceFirst(
            '{min}',
            min.toString(),
          ),
          namedArgs: {'min': min.toString()},
        ),
      };
    }

    if (max != null && value.length > max!) {
      return {
        greaterThanMax: App.text(
          LocaleKeys.core.validate.iterable_length.greater_than_max,
          defaultValue: 'Số lượng phải nhỏ hơn hoặc bằng {max}'.replaceFirst(
            '{max}',
            max.toString(),
          ),
          namedArgs: {'max': max.toString()},
        ),
      };
    }

    return null;
  }
}

class AppOtpValidator extends Validator<String?> {
  const AppOtpValidator({this.length = 6});

  final int length;

  static String invalid = '$AppOtpValidator.invalid';

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (value.length != length) {
      return {
        invalid: App.text(
          LocaleKeys.core.validate.otp.invalid,
          defaultValue: 'Mã OTP phải có {length} chữ số'.replaceFirst(
            '{length}',
            length.toString(),
          ),
          namedArgs: {'length': length.toString()},
        ),
      };
    }

    return null;
  }
}

class AppPasswordValidator extends Validator<String?> {
  const AppPasswordValidator({this.minLength = 8, this.containNumber = false});

  static String lessThanMin = '$AppPasswordValidator.less_than_min';
  static String noNumber = '$AppPasswordValidator.no_number';

  static final RegExp _numberRegex = RegExp('[0-9]');

  final int minLength;

  final bool containNumber;

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (value.length < minLength) {
      return {
        lessThanMin: App.text(
          LocaleKeys.core.validate.password.less_than_min,
          defaultValue: 'Mật khẩu phải có ít nhất {min} ký tự'.replaceFirst(
            '{min}',
            minLength.toString(),
          ),
          namedArgs: {'min': minLength.toString()},
        ),
      };
    }
    if (containNumber && !value.contains(_numberRegex)) {
      return {
        noNumber: App.text(
          LocaleKeys.core.validate.password.no_number,
          defaultValue: 'Mật khẩu phải có ít nhất 1 số',
        ),
      };
    }
    return null;
  }
}

class AppConfirmPasswordValidator extends Validator<String?> {
  const AppConfirmPasswordValidator({required this.passwordControl});

  static String notMatch = '$AppConfirmPasswordValidator.not_match';

  final FormControl<String?> passwordControl;

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (value != passwordControl.value) {
      return {
        notMatch: App.text(
          LocaleKeys.core.validate.confirm_password.not_match,
          defaultValue: 'Mật khẩu không khớp',
        ),
      };
    }

    return null;
  }
}

class AppDateValidator extends Validator<DateTime?> {
  const AppDateValidator({this.min, this.max});

  static String lessThanMin = '$AppDateValidator.less_than_min';
  static String greaterThanMax = '$AppDateValidator.greater_than_max';

  final DateTime? min;

  final DateTime? max;

  @override
  Map<String, dynamic>? validate(AbstractControl<DateTime?> control) {
    final DateTime? value = control.value;

    if (value == null) return null;

    if (min != null && value.isBefore(min!)) {
      final String minText = min.showDate();
      return {
        lessThanMin: App.text(
          LocaleKeys.core.validate.date.less_than_min,
          defaultValue: 'Ngày phải sau hoặc bằng {min}'.replaceFirst(
            '{min}',
            minText,
          ),
          namedArgs: {'min': minText},
        ),
      };
    }

    if (max != null && value.isAfter(max!)) {
      final String maxText = max.showDate();
      return {
        greaterThanMax: App.text(
          LocaleKeys.core.validate.date.greater_than_max,
          defaultValue: 'Ngày phải trước hoặc bằng {max}'.replaceFirst(
            '{max}',
            maxText,
          ),
          namedArgs: {'max': maxText},
        ),
      };
    }

    return null;
  }
}

class AppStringLengthValidator extends Validator<String?> {
  const AppStringLengthValidator({this.min, this.max});

  static String lessThanMin = '$AppStringLengthValidator.less_than_min';
  static String greaterThanMax = '$AppStringLengthValidator.greater_than_max';

  final int? min;

  final int? max;

  @override
  Map<String, dynamic>? validate(AbstractControl<String?> control) {
    final String? value = control.value;

    if (value == null || value.isEmpty) return null;

    if (min != null && value.length < min!) {
      return {
        lessThanMin: App.text(
          LocaleKeys.core.validate.string_length.less_than_min,
          defaultValue: 'Chuỗi phải có ít nhất {min} ký tự'.replaceFirst(
            '{min}',
            min.toString(),
          ),
          namedArgs: {'min': min.toString()},
        ),
      };
    }
    if (max != null && value.length > max!) {
      return {
        greaterThanMax: App.text(
          LocaleKeys.core.validate.string_length.greater_than_max,
          defaultValue: 'Chuỗi phải có ít nhất {max} ký tự'.replaceFirst(
            '{max}',
            max.toString(),
          ),
          namedArgs: {'max': max.toString()},
        ),
      };
    }
    return null;
  }
}
