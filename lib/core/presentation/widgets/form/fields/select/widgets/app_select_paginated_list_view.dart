import 'package:flutter/material.dart';
import 'package:template/app/app.dart';
import 'package:template/gen/locale_keys.gen.dart';

import '../../../../../../theme/app_fonts.dart';
import '../../../../../../theme/app_spacing.dart';
import '../../../../app_search_bar.dart';
import '../../../../app_text.dart';
import '../base/app_select_typedefs.dart';
import '../data_source/app_select_data_source.dart';

part 'src/app_select_paginated_list_view_states.dart';

/// Reusable widget to display a paginated list of items in select popups
///
/// Features:
/// - Scroll to load more when user scrolls to bottom (threshold: 200px)
/// - Loading indicator when loading next page
/// - Error handling with retry mechanism
/// - Empty state when no items
/// - Pull-to-refresh to reload page 1
/// - Optional search bar with debounce
///
/// Usage:
/// ```dart
/// AppSelectPaginatedListView<String>(
///   dataSource: dataSource,
///   itemDisplay: (item) => item,
///   getItemIdentity: (item) => item,
///   itemBuilder: (context, item, isSelected, onTap) => ListTile(...),
///   selectedItem: currentValue,
/// )
/// ```
class AppSelectPaginatedListView<T> extends StatefulWidget {
  const AppSelectPaginatedListView({
    super.key,
    required this.dataSource,
    required this.itemDisplay,
    required this.getItemIdentity,
    required this.itemBuilder,
    this.emptyMessage,
    this.scrollController,
    this.separatorBuilder,
    this.shrinkWrap = false,
    this.padding = EdgeInsets.zero,
    this.scrollDirection = Axis.vertical,
    this.showSearchBar = false,
    this.searchHint,
  });

  /// Data source for loading items
  final AppSelectDataSource<T> dataSource;

  /// Function to display item as text
  final AppItemDisplay<T> itemDisplay;

  /// Function to get unique identity of item for comparison
  final Object Function(T item) getItemIdentity;

  /// Builder function to render each item
  ///
  /// Parameters:
  /// - [context]: Build context
  /// - [item]: The item to render
  ///
  /// Note: Selection state is managed by parent (bottomsheet/dialog),
  /// parent should calculate isSelected if needed.
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Empty state message
  final String? emptyMessage;

  /// Optional scroll controller (creates new one if null)
  final ScrollController? scrollController;

  /// Optional separator builder between items
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  final bool shrinkWrap;

  final EdgeInsetsGeometry? padding;

  final Axis scrollDirection;

  /// Whether to show search bar
  final bool showSearchBar;

  /// Search bar hint text
  final String? searchHint;

  @override
  State<AppSelectPaginatedListView<T>> createState() =>
      _AppSelectPaginatedListViewState<T>();
}

class _AppSelectPaginatedListViewState<T>
    extends State<AppSelectPaginatedListView<T>> {
  /// All items loaded from all pages
  final List<T> _allItems = [];

  /// Current page number
  int _currentPage = 1;

  /// Whether currently loading a page
  bool _isLoading = false;

  /// Whether there are more pages available
  bool _hasMore = true;

  /// Error message if loading failed
  String? _error;

  /// Scroll controller (created if not provided)
  late ScrollController _scrollController;

  /// Whether we created the scroll controller (need to dispose)
  bool _ownsScrollController = false;

  /// Current search query
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();

    // Use provided scroll controller or create new one
    if (widget.scrollController != null) {
      _scrollController = widget.scrollController!;
      _ownsScrollController = false;
    } else {
      _scrollController = ScrollController();
      _ownsScrollController = true;
    }

    // Add scroll listener to detect scroll to bottom
    _scrollController.addListener(_onScroll);

    // Load initial page
    _loadPage(1);
  }

  @override
  void dispose() {
    // Remove scroll listener
    _scrollController.removeListener(_onScroll);

    // Dispose scroll controller if we created it
    if (_ownsScrollController) {
      _scrollController.dispose();
    }

    super.dispose();
  }

  /// Scroll listener to detect when user scrolls near bottom
  void _onScroll() {
    // Check if scrolled to bottom (threshold: 200px from bottom)
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  /// Handle search query change
  void _onSearchChanged(String value) {
    _searchQuery = value;
    // Reset and reload with new search
    _loadPage(1);
  }

  /// Load items for a specific page
  Future<void> _loadPage(int page) async {
    // Prevent duplicate loads
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await widget.dataSource.load(
        search: _searchQuery,
        page: page,
      );

      if (!mounted) return;

      setState(() {
        // Clear items if loading page 1 (refresh or new search)
        if (page == 1) {
          _allItems.clear();
        }

        // Add new items
        _allItems.addAll(result.items);

        // Update state
        _currentPage = page;
        _hasMore = result.hasMore;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  /// Load next page
  Future<void> _loadMore() async {
    if (!_hasMore || _isLoading) return;
    await _loadPage(_currentPage + 1);
  }

  @override
  Widget build(BuildContext context) {
    final content = _buildContent(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showSearchBar) _buildSearchBar(context),
        // Use Flexible only when not shrinkWrap to allow expansion
        // When shrinkWrap, content sizes itself to fit items
        if (widget.shrinkWrap) content else Flexible(child: content),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.s4,
        right: AppSpacing.s4,
        bottom: AppSpacing.s3,
      ),
      child: AppSearchBar(
        hintText: widget.searchHint,
        onChanged: _onSearchChanged,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    // Show error state
    if (_error != null && _allItems.isEmpty) {
      return _AppSelectPaginatedListViewError(error: _error!);
    }

    // Show empty state
    if (_allItems.isEmpty && !_isLoading) {
      return _AppSelectPaginatedListViewEmpty(message: widget.emptyMessage);
    }

    // Show loading state for initial load
    if (_allItems.isEmpty && _isLoading) {
      return const _AppSelectPaginatedListViewLoading();
    }

    return ListView.separated(
      controller: _scrollController,
      shrinkWrap: widget.shrinkWrap,
      scrollDirection: widget.scrollDirection,
      physics: const BouncingScrollPhysics(),
      padding: widget.padding,
      itemCount: _allItems.length,
      separatorBuilder:
          widget.separatorBuilder ??
          (context, index) => const Divider(
            height: 1,
            indent: AppSpacing.s2,
            endIndent: AppSpacing.s2,
          ),
      itemBuilder: (context, index) {
        // Build item - parent manages selection state
        final item = _allItems[index];
        return widget.itemBuilder(context, item);
      },
    );
  }
}
