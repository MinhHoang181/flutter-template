/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  Locale Gen Keys
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

class LocaleKeys {
  LocaleKeys._();

  static const core = _CoreGen();
  static const splash = _SplashGen();
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

class _CoreGen {
  const _CoreGen();
  final _CoreDialogGen dialog = const _CoreDialogGen();
  final _CoreErrorScreenGen error_screen = const _CoreErrorScreenGen();
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

