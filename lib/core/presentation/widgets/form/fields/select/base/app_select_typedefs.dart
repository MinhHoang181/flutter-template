import 'package:flutter/widgets.dart';

import '../data_source/app_select_data_source.dart';

/// Function type for displaying an item as text.
///
/// Converts an item of type [T] into a human-readable string for display
/// in the field and popup.
typedef AppItemDisplay<T> = String Function(T item);

/// Function type for getting the value of an item.
///
/// Used to get the value of an item for form control value.
typedef AppItemValue<TValue, TItem> = TValue Function(TItem item);

/// Function type for getting the unique identity of an item.
///
/// Returns a unique identifier for each item (typically an ID or primary key).
/// Used to compare items for equality and determine if an item is selected.
typedef AppItemIdentity<T> = Object Function(T item);

/// Function type for building a custom item widget in the popup.
///
/// Allows custom rendering of items in the selection popup with custom
/// styling, icons, or layout.
typedef AppItemBuilder<T> =
    Widget Function(BuildContext context, T item, bool isSelected);

/// Function type for loading paginated items from a data source.
///
/// Loads items from an API or remote source with pagination support.
/// Returns a [Future] that completes with an [AppSelectDataPage].
typedef AppItemsLoader<T> =
    Future<AppSelectDataPage<T>> Function(String search, int page);

/// Function type for filtering a list of items based on a search query.
///
/// Allows custom filtering logic beyond simple string matching.
/// Returns a filtered list of items matching the search criteria.
typedef AppItemFilter<T> = List<T> Function(List<T> items, String search);
