/// Result model for paginated data loading.
///
/// Represents a single page of items loaded from a data source with
/// pagination metadata.
class AppSelectDataPage<T> {
  const AppSelectDataPage({
    required this.items,
    this.page = 1,
    this.hasMore = false,
    this.totalCount = 0,
  });

  /// Items of the current page.
  final List<T> items;

  /// Page number (1-indexed, may be -1 if error).
  final int page;

  /// Whether there are more pages available.
  final bool hasMore;

  /// Total number of items across all pages (may be -1 if unknown).
  final int totalCount;
}

/// Abstract data source interface for loading items (fixed/paginated).
///
/// Defines the contract for providing items to select fields. Use
/// [AppSelectFixedDataSource] for fixed lists or [AppSelectPaginatedDataSource]
/// for paginated API data.
abstract class AppSelectDataSource<T> {
  const factory AppSelectDataSource.empty() = _AppSelectDataSourceEmpty;

  /// Load items with search and pagination.
  ///
  /// Returns a [Future] that completes with an [AppSelectDataPage].
  Future<AppSelectDataPage<T>> load({String search = '', int page = 1});

  /// Get cached items for page 1 with empty search (if available).
  ///
  /// Returns `null` if not cached yet.
  AppSelectDataPage<T>? getCached();

  /// Preload items for page 1 with empty search.
  ///
  /// Typically called in `initState()` to optimize popup opening speed.
  Future<AppSelectDataPage<T>> preload();

  /// Get stream of items.
  ///
  /// Returns a [Stream] that emits [AppSelectDataPage] of items.
  Stream<AppSelectDataPage<T>> get stream;
}

final class _AppSelectDataSourceEmpty<T> implements AppSelectDataSource<T> {
  const _AppSelectDataSourceEmpty();

  @override
  AppSelectDataPage<T>? getCached() {
    return null;
  }

  @override
  Future<AppSelectDataPage<T>> load({String search = '', int page = 1}) {
    return Future.value(const AppSelectDataPage(items: []));
  }

  @override
  Future<AppSelectDataPage<T>> preload() {
    return Future.value(const AppSelectDataPage(items: []));
  }

  @override
  Stream<AppSelectDataPage<T>> get stream =>
      Stream.value(const AppSelectDataPage(items: []));
}
