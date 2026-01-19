import 'dart:async';

import '../base/app_select_typedefs.dart';
import 'app_select_data_source.dart';

class AppSelectFetchDataSource<T> implements AppSelectDataSource<T> {
  AppSelectFetchDataSource({
    required this.loader,
    required this.filter,
    this.key,
  });

  /// Function to load items from API or async data source.
  ///
  /// Receives search query and page number, returns [AppSelectDataPage].
  final AppItemsLoader<T> loader;

  /// Function to filter items based on a search query.
  ///
  /// Receives a list of items and a search query, returns a filtered list of items.
  final AppItemFilter<T> filter;

  /// Optional key to identify this data source.
  /// When key changes, widgets should reload data.
  final Object? key;

  final List<T> _items = [];

  final StreamController<AppSelectDataPage<T>> _streamController =
      StreamController.broadcast();

  @override
  Stream<AppSelectDataPage<T>> get stream => _streamController.stream;

  @override
  AppSelectDataPage<T> getCached() => AppSelectDataPage(
    items: _items,
    page: 1,
    hasMore: false,
    totalCount: _items.length,
  );

  @override
  Future<AppSelectDataPage<T>> preload() async {
    await load(search: '', page: 1);
    final result = getCached();
    _streamController.add(result);
    return result;
  }

  @override
  Future<AppSelectDataPage<T>> load({String search = '', int page = 1}) async {
    try {
      final dataPage = await loader(search, page);

      final List<T> filteredItems = filter.call(dataPage.items, search);

      _items.clear();
      _items.addAll(filteredItems);

      final result = getCached();

      _streamController.add(result);

      return result;
    } catch (_) {
      return getCached();
    }
  }
}
