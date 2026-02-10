import 'package:flutter/material.dart';
extension MapExt on Map<dynamic, dynamic> {
  dynamic getString(dynamic key) => this[key] ?? '';
}
extension StringExt on String {
  bool get isLooksLikeDataUriBase64 => false;
  bool isLooksLikeRawBase64() => false;
}
