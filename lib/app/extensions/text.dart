part of '../app.dart';

extension TextExt on _AppExt {
  String text(String key, {required String defaultValue, Map<String, String>? namedArgs, String? gender}) =>
      trExists(key) ? tr(key, namedArgs: namedArgs, gender: gender) : defaultValue;
}

extension TextContextExt on BuildContext {
  String text(String key, {required String defaultValue, Map<String, String>? namedArgs, String? gender}) {
    return trExists(key, context: this) ? tr(key, context: this, namedArgs: namedArgs, gender: gender) : defaultValue;
  }
}
