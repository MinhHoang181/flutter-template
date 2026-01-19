import 'dart:async';

import '../base/app_select_typedefs.dart';
import 'app_select_data_source.dart';

/// Data source implementation for paginated API with loader function.
///
/// Loads items from a remote API or async data source with pagination support.
/// Handles caching and error recovery (returns empty page on error).
class AppSelectPaginatedDataSource<T> implements AppSelectDataSource<T> {
  AppSelectPaginatedDataSource({required this.loader});

  /// Function to load items from API or async data source.
  ///
  /// Receives search query and page number, returns [AppSelectDataPage].
  final AppItemsLoader<T> loader;

  /// Cached items for empty search
  AppSelectDataPage<T>? _cachedItems;

  final StreamController<AppSelectDataPage<T>> _streamController =
      StreamController.broadcast();

  @override
  Stream<AppSelectDataPage<T>> get stream => _streamController.stream;

  @override
  AppSelectDataPage<T>? getCached() => _cachedItems;

  @override
  Future<AppSelectDataPage<T>> preload() async {
    _cachedItems ??= await load(search: '', page: 1);
    _streamController.add(_cachedItems!);
    return _cachedItems!;
  }

  @override
  Future<AppSelectDataPage<T>> load({String search = '', int page = 1}) async {
    try {
      final dataPage = await loader(search, page);

      // Cache only for empty search, page 1
      if (search.isEmpty && page == 1) {
        _cachedItems = dataPage;
      }

      _streamController.add(dataPage);

      return dataPage;
    } catch (_) {
      return AppSelectDataPage<T>(
        items: [],
        page: -1,
        hasMore: false,
        totalCount: -1,
      );
    }
  }
}
