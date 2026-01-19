/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  Locale Gen Keys
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

class LocaleKeys {
  LocaleKeys._();

  static const app = _AppGen();
  static const business = _BusinessGen();
  static const core = _CoreGen();
  static const splash = _SplashGen();
}

class _AppNetworkAuthInterceptorEndSessionGen {
  const _AppNetworkAuthInterceptorEndSessionGen();
  final String message = 'app.network.auth_interceptor.end_session.message';
  final String title = 'app.network.auth_interceptor.end_session.title';
}

class _AppNetworkAuthInterceptorGen {
  const _AppNetworkAuthInterceptorGen();
  final _AppNetworkAuthInterceptorEndSessionGen end_session = const _AppNetworkAuthInterceptorEndSessionGen();
}

class _AppNetworkGen {
  const _AppNetworkGen();
  final _AppNetworkAuthInterceptorGen auth_interceptor = const _AppNetworkAuthInterceptorGen();
}

class _AppGen {
  const _AppGen();
  final _AppNetworkGen network = const _AppNetworkGen();
}

class _BusinessApiExceptionGen {
  const _BusinessApiExceptionGen();
  final String bad_certificate = 'business.api_exception.bad_certificate';
  final String bad_response = 'business.api_exception.bad_response';
  final String connection_error = 'business.api_exception.connection_error';
  final String connection_timeout = 'business.api_exception.connection_timeout';
  final String receive_timeout = 'business.api_exception.receive_timeout';
  final String send_timeout = 'business.api_exception.send_timeout';
}

class _BusinessGen {
  const _BusinessGen();
  final _BusinessApiExceptionGen api_exception = const _BusinessApiExceptionGen();
}

class _CoreBottomsheetDateTimePickerTitleGen {
  const _CoreBottomsheetDateTimePickerTitleGen();
  final String date = 'core.bottomsheet.date_time_picker.title.date';
  final String date_time = 'core.bottomsheet.date_time_picker.title.date_time';
  final String time = 'core.bottomsheet.date_time_picker.title.time';
}

class _CoreBottomsheetDateTimePickerGen {
  const _CoreBottomsheetDateTimePickerGen();
  final _CoreBottomsheetDateTimePickerTitleGen title = const _CoreBottomsheetDateTimePickerTitleGen();
}

class _CoreBottomsheetGen {
  const _CoreBottomsheetGen();
  final _CoreBottomsheetDateTimePickerGen date_time_picker = const _CoreBottomsheetDateTimePickerGen();
}

class _CoreDialogConfirmButtonGen {
  const _CoreDialogConfirmButtonGen();
  final String cancel = 'core.dialog.confirm.button.cancel';
  final String confirm = 'core.dialog.confirm.button.confirm';
}

class _CoreDialogConfirmGen {
  const _CoreDialogConfirmGen();
  final _CoreDialogConfirmButtonGen button = const _CoreDialogConfirmButtonGen();
  final String title = 'core.dialog.confirm.title';
}

class _CoreDialogDatePickerButtonsGen {
  const _CoreDialogDatePickerButtonsGen();
  final String done = 'core.dialog.date_picker.buttons.done';
  final String reset = 'core.dialog.date_picker.buttons.reset';
}

class _CoreDialogDatePickerGen {
  const _CoreDialogDatePickerGen();
  final _CoreDialogDatePickerButtonsGen buttons = const _CoreDialogDatePickerButtonsGen();
}

class _CoreDialogDevelopButtonGen {
  const _CoreDialogDevelopButtonGen();
  final String close = 'core.dialog.develop.button.close';
}

class _CoreDialogDevelopGen {
  const _CoreDialogDevelopGen();
  final _CoreDialogDevelopButtonGen button = const _CoreDialogDevelopButtonGen();
  final String message = 'core.dialog.develop.message';
  final String title = 'core.dialog.develop.title';
}

class _CoreDialogErrorButtonGen {
  const _CoreDialogErrorButtonGen();
  final String close = 'core.dialog.error.button.close';
}

class _CoreDialogErrorGen {
  const _CoreDialogErrorGen();
  final _CoreDialogErrorButtonGen button = const _CoreDialogErrorButtonGen();
  final String title = 'core.dialog.error.title';
}

class _CoreDialogSuccessButtonGen {
  const _CoreDialogSuccessButtonGen();
  final String close = 'core.dialog.success.button.close';
}

class _CoreDialogSuccessGen {
  const _CoreDialogSuccessGen();
  final _CoreDialogSuccessButtonGen button = const _CoreDialogSuccessButtonGen();
  final String title = 'core.dialog.success.title';
}

class _CoreDialogWarningButtonGen {
  const _CoreDialogWarningButtonGen();
  final String cancel = 'core.dialog.warning.button.cancel';
  final String confirm = 'core.dialog.warning.button.confirm';
}

class _CoreDialogWarningGen {
  const _CoreDialogWarningGen();
  final _CoreDialogWarningButtonGen button = const _CoreDialogWarningButtonGen();
  final String title = 'core.dialog.warning.title';
}

class _CoreDialogGen {
  const _CoreDialogGen();
  final _CoreDialogConfirmGen confirm = const _CoreDialogConfirmGen();
  final _CoreDialogDatePickerGen date_picker = const _CoreDialogDatePickerGen();
  final _CoreDialogDevelopGen develop = const _CoreDialogDevelopGen();
  final _CoreDialogErrorGen error = const _CoreDialogErrorGen();
  final _CoreDialogSuccessGen success = const _CoreDialogSuccessGen();
  final _CoreDialogWarningGen warning = const _CoreDialogWarningGen();
}

class _CoreErrorScreenGen {
  const _CoreErrorScreenGen();
  final String app_bar = 'core.error_screen.app_bar';
  final String back_home = 'core.error_screen.back_home';
  final String message = 'core.error_screen.message';
}

class _CoreSearchBarGen {
  const _CoreSearchBarGen();
  final String hint = 'core.search_bar.hint';
}

class _CoreValidateConfirmPasswordGen {
  const _CoreValidateConfirmPasswordGen();
  final String not_match = 'core.validate.confirm_password.not_match';
}

class _CoreValidateDateGen {
  const _CoreValidateDateGen();
  final String greater_than_max = 'core.validate.date.greater_than_max';
  final String less_than_min = 'core.validate.date.less_than_min';
}

class _CoreValidateDateOfBirthGen {
  const _CoreValidateDateOfBirthGen();
  final String future_date = 'core.validate.date_of_birth.future_date';
  final String too_old = 'core.validate.date_of_birth.too_old';
}

class _CoreValidateEmailGen {
  const _CoreValidateEmailGen();
  final String invalid = 'core.validate.email.invalid';
}

class _CoreValidateIterableLengthGen {
  const _CoreValidateIterableLengthGen();
  final String greater_than_max = 'core.validate.iterable_length.greater_than_max';
  final String less_than_min = 'core.validate.iterable_length.less_than_min';
}

class _CoreValidateNationalIdGen {
  const _CoreValidateNationalIdGen();
  final String invalid = 'core.validate.national_id.invalid';
}

class _CoreValidateNumCompareGen {
  const _CoreValidateNumCompareGen();
  final String greater_than_max = 'core.validate.num_compare.greater_than_max';
  final String less_than_min = 'core.validate.num_compare.less_than_min';
  final String not_equal = 'core.validate.num_compare.not_equal';
}

class _CoreValidateOtpGen {
  const _CoreValidateOtpGen();
  final String invalid = 'core.validate.otp.invalid';
}

class _CoreValidatePasswordGen {
  const _CoreValidatePasswordGen();
  final String less_than_min = 'core.validate.password.less_than_min';
  final String no_number = 'core.validate.password.no_number';
}

class _CoreValidatePhoneGen {
  const _CoreValidatePhoneGen();
  final String invalid = 'core.validate.phone.invalid';
}

class _CoreValidateStringLengthGen {
  const _CoreValidateStringLengthGen();
  final String greater_than_max = 'core.validate.string_length.greater_than_max';
  final String less_than_min = 'core.validate.string_length.less_than_min';
}

class _CoreValidateGen {
  const _CoreValidateGen();
  final _CoreValidateConfirmPasswordGen confirm_password = const _CoreValidateConfirmPasswordGen();
  final _CoreValidateDateGen date = const _CoreValidateDateGen();
  final _CoreValidateDateOfBirthGen date_of_birth = const _CoreValidateDateOfBirthGen();
  final _CoreValidateEmailGen email = const _CoreValidateEmailGen();
  final String is_required = 'core.validate.is_required';
  final _CoreValidateIterableLengthGen iterable_length = const _CoreValidateIterableLengthGen();
  final _CoreValidateNationalIdGen national_id = const _CoreValidateNationalIdGen();
  final _CoreValidateNumCompareGen num_compare = const _CoreValidateNumCompareGen();
  final _CoreValidateOtpGen otp = const _CoreValidateOtpGen();
  final _CoreValidatePasswordGen password = const _CoreValidatePasswordGen();
  final _CoreValidatePhoneGen phone = const _CoreValidatePhoneGen();
  final _CoreValidateStringLengthGen string_length = const _CoreValidateStringLengthGen();
}

class _CoreGen {
  const _CoreGen();
  final _CoreBottomsheetGen bottomsheet = const _CoreBottomsheetGen();
  final _CoreDialogGen dialog = const _CoreDialogGen();
  final String empty = 'core.empty';
  final _CoreErrorScreenGen error_screen = const _CoreErrorScreenGen();
  final String retry = 'core.retry';
  final _CoreSearchBarGen search_bar = const _CoreSearchBarGen();
  final _CoreValidateGen validate = const _CoreValidateGen();
  final String version = 'core.version';
}

class _SplashErrorDialogButtonGen {
  const _SplashErrorDialogButtonGen();
  final String retry = 'splash.error_dialog.button.retry';
}

class _SplashErrorDialogGen {
  const _SplashErrorDialogGen();
  final _SplashErrorDialogButtonGen button = const _SplashErrorDialogButtonGen();
  final String message = 'splash.error_dialog.message';
}

class _SplashGen {
  const _SplashGen();
  final _SplashErrorDialogGen error_dialog = const _SplashErrorDialogGen();
}

