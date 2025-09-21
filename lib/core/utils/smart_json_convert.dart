import 'dart:convert';

import 'package:flutter/foundation.dart';

class SmartJsonDecoder {
  static const int _threshold = 5000;

  static Future<dynamic> decode(String jsonString) async {
    if (jsonString.length >= _threshold) {
      return compute(jsonDecode, jsonString);
    } else {
      return jsonDecode(jsonString);
    }
  }
}

class SmartJsonEncoder {
  static const int _threshold = 1000; // object.toString().length

  static Future<String> encode(Object object) async {
    final roughSize = object.toString().length;
    if (roughSize >= _threshold) {
      return compute(jsonEncode, object);
    } else {
      return jsonEncode(object);
    }
  }
}
