import 'dart:convert';
import 'dart:typed_data';

import 'package:core_extension/core_extension.dart';
import 'package:json_annotation/json_annotation.dart';

const List<JsonConverter> jsonConverters = [
  JsonFieldConverterIntOrNull(),
  JsonFieldConverterDoubleOrNull(),
  // string
  JsonFieldConverterStringOrNull(),
  // bool
  JsonFieldConverterBoolOrNull(),
  // datetime
  JsonFieldConverterDateTimeOrNull(),
  // map
  JsonFieldConverterMapOrNull(),
  JsonFieldConverterMapStringOrNull(),
  // list
  JsonFieldConverterListOrNull(),
  JsonFieldConverterListStringOrNull(),
  JsonFieldConverterListNumOrNull(),
  JsonFieldConverterListMapOrNull(),
];

class JsonFieldConverterIntOrNull extends JsonConverter<int?, dynamic> {
  const JsonFieldConverterIntOrNull();

  @override
  int? fromJson(dynamic json) => (json as Object?).toIntOrNull();

  @override
  dynamic toJson(int? object) => object;
}

class JsonFieldConverterInt extends JsonConverter<int, dynamic> {
  const JsonFieldConverterInt();

  @override
  int fromJson(dynamic json) => (json as Object?).toInt(defaultValue: 0);

  @override
  dynamic toJson(int object) => object;
}

class JsonFieldConverterDoubleOrNull extends JsonConverter<double?, dynamic> {
  const JsonFieldConverterDoubleOrNull();

  @override
  double? fromJson(dynamic json) => (json as Object?).toDoubleOrNull();

  @override
  dynamic toJson(double? object) => object;
}

class JsonFieldConverterDouble extends JsonConverter<double, dynamic> {
  const JsonFieldConverterDouble();

  @override
  double fromJson(dynamic json) =>
      (json as Object?).toDouble(defaultValue: 0.0);

  @override
  dynamic toJson(double object) => object;
}

class JsonFieldConverterStringOrNull extends JsonConverter<String?, dynamic> {
  const JsonFieldConverterStringOrNull();

  @override
  String? fromJson(dynamic json) => (json as Object?).toStringOrNull();

  @override
  dynamic toJson(String? object) => object;
}

class JsonFieldConverterString extends JsonConverter<String, dynamic> {
  const JsonFieldConverterString();

  @override
  String fromJson(dynamic json) => (json as Object?).toStringOrNull() ?? '';

  @override
  dynamic toJson(String object) => object;
}

class JsonFieldConverterBoolOrNull extends JsonConverter<bool?, dynamic> {
  const JsonFieldConverterBoolOrNull();

  @override
  bool? fromJson(dynamic json) => (json as Object?).toBoolOrNull();

  @override
  dynamic toJson(bool? object) => object;
}

class JsonFieldConverterBool extends JsonConverter<bool, dynamic> {
  const JsonFieldConverterBool();

  @override
  bool fromJson(dynamic json) => (json as Object?).toBool(defaultValue: false);

  @override
  dynamic toJson(bool object) => object;
}

class JsonFieldConverterDateTimeOrNull
    extends JsonConverter<DateTime?, dynamic> {
  const JsonFieldConverterDateTimeOrNull();

  @override
  DateTime? fromJson(dynamic json) => (json as Object?).toDateTimeOrNull();

  @override
  dynamic toJson(DateTime? object) {
    if (object == null) return null;

    final String json = (object as DateTime?).showDate(
      format: 'yyyy-MM-dd HH:mm:ss',
    );

    return json.isEmpty ? null : json;
  }
}

class JsonFieldConverterDateTime extends JsonConverter<DateTime, dynamic> {
  const JsonFieldConverterDateTime();

  @override
  DateTime fromJson(dynamic json) =>
      (json as Object?).toDateTime(defaultValue: DateTime(0));

  @override
  dynamic toJson(DateTime object) =>
      (object as DateTime?).showDate(format: 'yyyy-MM-dd HH:mm:ss');
}

class JsonFieldConverterDateOrNull extends JsonConverter<DateTime?, dynamic> {
  const JsonFieldConverterDateOrNull();

  @override
  DateTime? fromJson(dynamic json) => (json as Object?).toDateOrNull();

  @override
  dynamic toJson(DateTime? object) => object?.showDate(format: 'yyyy-MM-dd');
}

class JsonFieldConverterDate extends JsonConverter<DateTime, dynamic> {
  const JsonFieldConverterDate();

  @override
  DateTime fromJson(dynamic json) =>
      (json as Object?).toDate(defaultValue: DateTime(0));

  @override
  dynamic toJson(DateTime object) => object.showDate(format: 'yyyy-MM-dd');
}

class JsonFieldConverterMapOrNull extends JsonConverter<Map?, dynamic> {
  const JsonFieldConverterMapOrNull();

  @override
  Map? fromJson(dynamic json) => (json as Object?).toMapOrNull();

  @override
  dynamic toJson(Map? object) => object;
}

class JsonFieldConverterMap extends JsonConverter<Map, dynamic> {
  const JsonFieldConverterMap();

  @override
  Map fromJson(dynamic json) => (json as Object?).toMap();

  @override
  dynamic toJson(Map object) => object;
}

class JsonFieldConverterMapStringOrNull
    extends JsonConverter<Map<String, Object?>?, dynamic> {
  const JsonFieldConverterMapStringOrNull();

  @override
  Map<String, Object?>? fromJson(dynamic json) =>
      (json as Object?).toMapOrNull<String, Object?>();

  @override
  dynamic toJson(Map? object) => object;
}

class JsonFieldConverterListOrNull extends JsonConverter<List?, dynamic> {
  const JsonFieldConverterListOrNull();

  @override
  List? fromJson(dynamic json) => (json as Object?).toListOrNull();

  @override
  dynamic toJson(List? object) => object;
}

class JsonFieldConverterListStringOrNull
    extends JsonConverter<List<String>?, dynamic> {
  const JsonFieldConverterListStringOrNull();

  @override
  List<String>? fromJson(dynamic json) =>
      (json as Object?).toListOrNull<String>();

  @override
  dynamic toJson(List<String>? object) => object;
}

class JsonFieldConverterListString
    extends JsonConverter<List<String>, dynamic> {
  const JsonFieldConverterListString();

  @override
  List<String> fromJson(dynamic json) => (json as Object?).toList<String>();

  @override
  dynamic toJson(List? object) => object;
}

class JsonFieldConverterListNumOrNull
    extends JsonConverter<List<num>?, dynamic> {
  const JsonFieldConverterListNumOrNull();

  @override
  List<num>? fromJson(dynamic json) => (json as Object?).toListOrNull<num>();

  @override
  dynamic toJson(List? object) => object;
}

class JsonFieldConverterListIntOrNull
    extends JsonConverter<List<int>?, dynamic> {
  const JsonFieldConverterListIntOrNull();

  @override
  List<int>? fromJson(dynamic json) => (json as Object?).toListOrNull<int>();

  @override
  dynamic toJson(List<int>? object) => object;
}

class JsonFieldConverterListMapOrNull
    extends JsonConverter<List<Map>?, dynamic> {
  const JsonFieldConverterListMapOrNull();

  @override
  List<Map>? fromJson(dynamic json) => (json as Object?).toListOrNull<Map>();

  @override
  dynamic toJson(List? object) => object;
}

class JsonFieldConverterListStringOrNullToStringListOrNull
    extends JsonConverter<List<String>?, String?> {
  const JsonFieldConverterListStringOrNullToStringListOrNull();

  @override
  List<String>? fromJson(String? json) =>
      json?.split(',').toListOrNull<String>();

  @override
  String? toJson(List<String>? object) => object?.join(',');
}

class JsonFieldConverterListObjectOrNull
    extends JsonConverter<List<dynamic>?, dynamic> {
  const JsonFieldConverterListObjectOrNull();

  @override
  List<dynamic>? fromJson(dynamic json) {
    return (json as Object?)?.toListOrNull<dynamic>();
  }

  @override
  dynamic toJson(List<dynamic>? object) => object;
}

class JsonFieldConverterListObject
    extends JsonConverter<List<dynamic>, dynamic> {
  const JsonFieldConverterListObject();

  @override
  List<dynamic> fromJson(dynamic json) {
    return (json as Object?)?.toListOrNull<dynamic>() ?? [];
  }

  @override
  dynamic toJson(List<dynamic> object) => object;
}

class JsonFieldConverterUint8ListOrNull
    extends JsonConverter<Uint8List?, dynamic> {
  const JsonFieldConverterUint8ListOrNull();

  @override
  Uint8List? fromJson(dynamic json) {
    final String? stringJson = (json as Object?).toStringOrNull();
    if (stringJson == null || stringJson.isEmpty) return null;

    try {
      // Check if it's a Data URI (e.g., "data:image/png;base64,...")
      if (stringJson.isLooksLikeDataUriBase64) {
        // ignore: deprecated_member_use
        final match = RegExp(
          r'^data:[^;]+;base64,(.*)$',
          caseSensitive: false,
        ).firstMatch(stringJson);
        if (match != null) {
          final base64String = match.group(1);
          if (base64String != null && base64String.isNotEmpty) {
            return base64Decode(base64String);
          }
        }
        return null;
      }

      // Otherwise, treat as raw base64 string
      return base64Decode(stringJson);
    } catch (_) {
      return null;
    }
  }

  @override
  dynamic toJson(Uint8List? object) {
    if (object == null) return null;
    return base64Encode(object);
  }
}
