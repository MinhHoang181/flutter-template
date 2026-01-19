import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../blocs/pagination_cubit/pagination_cubit.dart';

class PaginationCubitSliverListView<T> extends StatelessWidget {
  const PaginationCubitSliverListView({
    super.key,
    required this.paginationCubit,
    required this.builderDelegate,
    required this.separatorBuilder,

    this.itemExtent,

    this.shrinkWrapFirstPageIndicators = false,
  });

  final PaginationCubit<T> paginationCubit;

  final PagedChildBuilderDelegate<T> builderDelegate;

  final IndexedWidgetBuilder separatorBuilder;

  final double? itemExtent;

  final bool shrinkWrapFirstPageIndicators;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      PaginationCubit<T>,
      PaginationState<T>,
      PagingState<int, T>
    >(
      bloc: paginationCubit,
      selector: (state) => state.pagingState,
      builder: (context, pagingState) {
        return PagedSliverList<int, T>.separated(
          state: pagingState,
          fetchNextPage: paginationCubit.fetchNextPage,
          builderDelegate: builderDelegate,
          separatorBuilder: separatorBuilder,
          itemExtent: itemExtent,
          shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        );
      },
    );
  }
}
