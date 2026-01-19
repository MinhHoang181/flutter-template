import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:template/business/models/pagination.dart';
import 'package:template/core/classes/interfaces.dart';
import 'package:template/core/utils/async_deduplicator.dart';
import 'package:template/core/utils/either.dart';

part 'pagination_cubit.freezed.dart';
part 'pagination_state.dart';

abstract class PaginationCubit<T> extends Cubit<PaginationState<T>> {
  PaginationCubit({this.iRefresh})
    : super(BasePaginationState.initial(pagingState: PagingState<int, T>())) {
    _refreshSubscription = iRefresh?.getRefreshStream().listen((item) {
      if (item == null) {
        refresh(background: true);
      }
    });
  }

  @protected
  final IRefresh<T>? iRefresh;

  final AsyncDeduplicator _fetchNextPageDeduplicator = AsyncDeduplicator();

  final AsyncDeduplicator _refreshDeduplicator = AsyncDeduplicator();

  StreamSubscription<T?>? _refreshSubscription;

  @override
  Future<void> close() {
    _refreshSubscription?.cancel();
    return super.close();
  }

  @protected
  Future<Either<Exception, Pagination<T>>> loadData(int page);

  Future<void> fetchNextPage() async {
    if (isClosed) return;

    return _fetchNextPageDeduplicator.fetch(() async {
      emit(
        BasePaginationState.fetching(
          pagingState: state.pagingState.copyWith(isLoading: true, error: null),
        ),
      );

      final int page = (state.pagingState.keys?.lastOrNull ?? 0) + 1;

      final result = await loadData(page);

      if (isClosed) return;

      result.fold(
        (error) {
          emit(
            BasePaginationState.fetchError(
              pagingState: state.pagingState.copyWith(
                error: error.toString(),
                isLoading: false,
              ),
              error: error,
            ),
          );
        },
        (pagination) {
          emit(
            BasePaginationState.fetchSuccess(
              pagingState: state.pagingState.copyWith(
                pages: [...?state.pagingState.pages, pagination.data],
                keys: [...?state.pagingState.keys, page],
                hasNextPage: page < pagination.pages,
                isLoading: false,
              ),
            ),
          );
        },
      );
    });
  }

  Future<void> refresh({
    /// If true, the refresh will not show the loading indicator/error message.
    bool background = false,

    /// If true, the refresh will override the current state.
    bool override = false,
  }) async {
    if (isClosed) return;
    if (state.pagingState.isLoading && !override) return;

    if (override) {
      _refreshDeduplicator.invalidate();
    }

    return _refreshDeduplicator.fetch(() async {
      if (!background) {
        emit(
          BasePaginationState.refreshing(
            pagingState: state.pagingState.copyWith(
              isLoading: true,
              error: null,
            ),
          ),
        );
      }

      const int page = 1;

      final result = await loadData(page);

      if (isClosed) return;

      result.fold(
        (error) {
          if (!background) {
            emit(
              BasePaginationState.refreshError(
                pagingState: state.pagingState.copyWith(isLoading: false),
                error: error,
              ),
            );
          }
        },
        (pagination) {
          emit(
            BasePaginationState.refreshSuccess(
              pagingState: state.pagingState.copyWith(
                pages: [pagination.data],
                keys: [1],
                hasNextPage: page < pagination.pages,
                isLoading: false,
              ),
            ),
          );
        },
      );
    });
  }

  void reset() {
    emit(BasePaginationState.initial(pagingState: PagingState<int, T>()));
  }
}
