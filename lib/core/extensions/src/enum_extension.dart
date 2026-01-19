part of '../extensions.dart';

/// Extension for enum values to filter out unknown values.
extension EnumListExtension<T extends Enum> on List<T> {
  /// Returns all enum values excluding values that start with '$' (like $unknown).
  /// This is useful for filtering out unknown values from client-generated enums
  /// when displaying them in select fields.
  List<T> get withoutUnknown {
    return where((value) => !value.name.startsWith(r'$')).toList();
  }
}
