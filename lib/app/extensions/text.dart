part of '../app.dart';

/// Extension on [_AppExt] to provide localization utilities.
extension TextExt on _AppExt {
  /// Returns the localized string for the given [key].
  ///
  /// If the translation exists in the current locale, it returns the translated string.
  /// Otherwise, it returns the provided [defaultValue].
  String text(String key, {required String defaultValue, Map<String, String>? namedArgs, String? gender}) =>
      trExists(key) ? tr(key, namedArgs: namedArgs, gender: gender) : defaultValue;
}

/// Extension on [BuildContext] to provide convenient access to localization.
extension TextContextExt on BuildContext {
  /// Returns the localized string for the given [key] using the current context.
  ///
  /// If the translation exists, it returns the translated string.
  /// Otherwise, it returns the provided [defaultValue].
  String text(String key, {required String defaultValue, Map<String, String>? namedArgs, String? gender}) {
    return trExists(key, context: this) ? tr(key, context: this, namedArgs: namedArgs, gender: gender) : defaultValue;
  }
}
