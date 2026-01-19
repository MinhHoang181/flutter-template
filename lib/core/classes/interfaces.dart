abstract interface class IEntity<Id extends Object, T> {
  Id get identity;

  bool isSame(T other);

  T merge(T? other);
}

abstract interface class IRefresh<T> {
  Stream<T?> getRefreshStream();

  void refresh();
}

abstract interface class IInitializable {
  Future<void> initialize({bool force = false});
}

abstract interface class IEntityList<
  Id extends Object,
  Entity extends IEntity<Id, Entity>
> {
  List<Entity> get items;

  Future<List<Entity>> getItems();

  Entity? item(Id id);

  Stream<Entity> getItemStream(Id id);

  Stream<List<Entity>> getItemsStream();
}
