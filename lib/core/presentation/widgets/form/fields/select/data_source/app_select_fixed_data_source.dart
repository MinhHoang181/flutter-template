import '../base/app_select_typedefs.dart';
import 'app_select_data_source.dart';

/// Data source implementation for fixed list with local filtering.
///
/// Provides items from a fixed list stored in memory. Supports local
/// filtering based on search queries and caches filtered results.
class AppSelectFixedDataSource<T> implements AppSelectDataSource<T> {
  AppSelectFixedDataSource({required this.items, required this.filter});

  /// The fixed list of items to select from.
  final List<T> items;

  /// Custom filter function (optional).
  final AppItemFilter<T> filter;

  @override
  AppSelectDataPage<T> getCached() => AppSelectDataPage(
    items: items,
    page: 1,
    hasMore: false,
    totalCount: items.length,
  );

  @override
  Stream<AppSelectDataPage<T>> get stream => Stream.value(getCached());

  @override
  Future<AppSelectDataPage<T>> preload() {
    return Future.value(getCached());
  }

  @override
  Future<AppSelectDataPage<T>> load({String search = '', int page = 1}) async {
    final filtered = filter.call(items, search);

    final result = AppSelectDataPage<T>(
      items: filtered,
      page: page,
      hasMore: false,
      totalCount: filtered.length,
    );

    return result;
  }
}
