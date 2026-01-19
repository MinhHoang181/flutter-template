import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:template/app/app.dart';

import '../utils/async_deduplicator.dart';
import 'cache_storage.dart';
import 'interfaces.dart';

abstract class CacheEntityListRepository<
  Id extends Object,
  Entity extends IEntity<Id, Entity>
>
    implements IInitializable, IEntityList<Id, Entity> {
  CacheEntityListRepository({this.cacheStorage});

  @protected
  final CacheEntityListStorage<Id, Entity>? cacheStorage;

  @protected
  final Map<Id, Entity> cachedItems = {};

  final StreamController<Entity> _itemStreamController =
      StreamController<Entity>.broadcast();

  final StreamController<List<Entity>> _itemsStreamController =
      StreamController<List<Entity>>.broadcast();

  final AsyncDeduplicator<List<Entity>> _fetchItemsDeduplicator =
      AsyncDeduplicator();

  @override
  List<Entity> get items => UnmodifiableListView(cachedItems.values);

  @override
  Entity? item(Id id) {
    return cachedItems[id];
  }

  @override
  Stream<Entity> getItemStream(Id id) => _itemStreamController.stream.transform(
    StreamTransformer.fromHandlers(
      handleData: (Entity item, sink) {
        if (item.identity == id) {
          sink.add(item);
        }
      },
    ),
  );

  @override
  Stream<List<Entity>> getItemsStream() => _itemsStreamController.stream;

  @override
  Future<void> initialize({bool force = false}) async {
    try {
      if (cachedItems.isEmpty || force) {
        await getItems();
      }
    } catch (error, stackTrace) {
      App.logError(
        title: '$runtimeType.initialize',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<List<Entity>> getItems() {
    return _fetchItemsDeduplicator.fetch(() async {
      final List<Entity> items = [];

      try {
        final values = await fetchItems();

        items.addAll(values);
      } catch (error, stackTrace) {
        App.logError(
          title: '$runtimeType.getItems',
          error: error,
          stackTrace: stackTrace,
        );
      }

      if (items.isEmpty) {
        try {
          final values = await cacheStorage?.loadItems();

          items.addAll(values ?? []);
        } catch (error, stackTrace) {
          App.logError(
            title: '$runtimeType.getItems',
            error: error,
            stackTrace: stackTrace,
          );
        }
      } else {
        try {
          unawaited(cacheStorage?.saveItems(items));
        } catch (error, stackTrace) {
          App.logError(
            title: '$runtimeType.getItems',
            error: error,
            stackTrace: stackTrace,
          );
        }
      }

      _syncItems(items);

      return UnmodifiableListView(cachedItems.values);
    });
  }

  void _syncItems(List<Entity> newItems) {
    for (final Entity newItem in newItems) {
      final updated = cachedItems.update(
        newItem.identity,
        (value) => value.merge(newItem),
        ifAbsent: () => newItem,
      );

      _itemStreamController.add(updated);
    }

    _itemsStreamController.add(items);
  }

  Future<List<Entity>> fetchItems();
}
