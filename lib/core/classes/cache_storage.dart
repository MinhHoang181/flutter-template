import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/json/smart_json_convert.dart';
import 'interfaces.dart';

abstract interface class CacheEntityListStorage<
  Id extends Object,
  Entity extends IEntity<Id, Entity>
> {
  Future<void> saveItems(List<Entity> items);

  Future<List<Entity>?> loadItems();

  Future<void> clearCache();
}

class CacheEntityListStorageImpl<
  Id extends Object,
  Entity extends IEntity<Id, Entity>
>
    implements CacheEntityListStorage<Id, Entity> {
  CacheEntityListStorageImpl({
    required SharedPreferences prefs,
    required this.cacheKey,
    required this.jsonConverter,
  }) : _prefs = prefs;

  final SharedPreferences _prefs;

  final String cacheKey;

  final JsonConverter<Entity, dynamic> jsonConverter;

  @override
  Future<void> saveItems(List<Entity> items) async {
    final jsonItems = await Future.wait<String>(
      items.map((e) => SmartJsonEncoder.encode(jsonConverter.toJson(e))),
    );

    await _prefs.setStringList(cacheKey, jsonItems);
  }

  @override
  Future<List<Entity>?> loadItems() async {
    final jsonStringList = _prefs.getStringList(cacheKey) ?? [];

    final items = await Future.wait<Entity>(
      jsonStringList.map(
        (e) => SmartJsonDecoder.decode(e).then(jsonConverter.fromJson),
      ),
    );

    return items;
  }

  @override
  Future<void> clearCache() async {
    await _prefs.remove(cacheKey);
  }
}
