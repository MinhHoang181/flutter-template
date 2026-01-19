import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template/core/utils/json/json_field_converter.dart';

part 'pagination.freezed.dart';
part 'pagination.g.dart';

class PaginationField {
  static const String total = 'total_items';
  static const String pages = 'total_pages';
  static const String limit = 'records_per_page';
  static const String current = 'current_page';
  static const String data = 'results';
}

@Freezed(genericArgumentFactories: true)
@JsonSerializable(converters: jsonConverters, genericArgumentFactories: true)
class Pagination<T> with _$Pagination<T> {
  Pagination({int? total, int? pages, int? limit, int? current, List<T>? data})
    : current = current ?? 1,
      total = total ?? 0,
      pages = pages ?? 1,
      limit = limit ?? 10,
      data = data ?? [];

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginationFromJson(json, fromJsonT);

  @override
  @JsonKey(name: PaginationField.total)
  @JsonFieldConverterInt()
  final int total;

  @override
  @JsonKey(name: PaginationField.pages)
  @JsonFieldConverterInt()
  final int pages;

  @override
  @JsonKey(name: PaginationField.limit)
  @JsonFieldConverterInt()
  final int limit;

  @override
  @JsonKey(name: PaginationField.current)
  @JsonFieldConverterInt()
  final int current;

  @override
  @JsonKey(name: PaginationField.data)
  final List<T> data;

  Map<String, dynamic> toJson(T Function(Object? json) toJsonT) =>
      _$PaginationToJson(this, toJsonT);
}
