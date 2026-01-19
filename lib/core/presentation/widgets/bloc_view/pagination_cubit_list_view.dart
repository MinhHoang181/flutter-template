import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../blocs/pagination_cubit/pagination_cubit.dart';

class PaginationCubitListView<T> extends StatelessWidget {
  const PaginationCubitListView({
    super.key,
    required this.paginationCubit,
    required this.builderDelegate,
    required this.separatorBuilder,
    this.scrollController,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.itemExtent,
    this.prototypeItem,
    this.cacheExtent,
    this.clipBehavior = Clip.hardEdge,
  });

  final PaginationCubit<T> paginationCubit;

  final PagedChildBuilderDelegate<T> builderDelegate;

  final IndexedWidgetBuilder separatorBuilder;

  final ScrollController? scrollController;

  final Axis scrollDirection;

  final bool reverse;

  final bool? primary;

  final ScrollPhysics? physics;

  final bool shrinkWrap;

  final EdgeInsets? padding;

  final double? itemExtent;

  final Widget? prototypeItem;

  final double? cacheExtent;

  final Clip clipBehavior;

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
        return PagedListView<int, T>.separated(
          state: pagingState,
          fetchNextPage: paginationCubit.fetchNextPage,
          builderDelegate: builderDelegate,
          separatorBuilder: separatorBuilder,
          scrollController: scrollController,
          scrollDirection: scrollDirection,
          reverse: reverse,
          primary: primary,
          physics: physics,
          shrinkWrap: shrinkWrap,
          padding: padding,
          itemExtent: itemExtent,
          cacheExtent: cacheExtent,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          clipBehavior: clipBehavior,
        );
      },
    );
  }
}
