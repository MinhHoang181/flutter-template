part of 'pagination_cubit.dart';

abstract class PaginationState<T> {
  const PaginationState({required this.pagingState});

  final PagingState<int, T> pagingState;
}

@Freezed(
  when: FreezedWhenOptions.all,
  map: FreezedMapOptions.all,
  toJson: false,
  fromJson: false,
  copyWith: false,
  genericArgumentFactories: true,
)
class BasePaginationState<T> extends PaginationState<T>
    with _$BasePaginationState<T> {
  const BasePaginationState._({required super.pagingState});

  const factory BasePaginationState.initial({
    required PagingState<int, T> pagingState,
  }) = _BasePaginationStateInitial;

  const factory BasePaginationState.fetching({
    required PagingState<int, T> pagingState,
  }) = _BasePaginationStateFetching;

  const factory BasePaginationState.fetchError({
    required PagingState<int, T> pagingState,
    required Exception error,
  }) = _BasePaginationStateFetchError;

  const factory BasePaginationState.fetchSuccess({
    required PagingState<int, T> pagingState,
  }) = _BasePaginationStateFetchSuccess;

  const factory BasePaginationState.refreshing({
    required PagingState<int, T> pagingState,
  }) = _BasePaginationStateRefreshing;

  const factory BasePaginationState.refreshError({
    required PagingState<int, T> pagingState,
    required Exception error,
  }) = _BasePaginationStateRefreshError;

  const factory BasePaginationState.refreshSuccess({
    required PagingState<int, T> pagingState,
  }) = _BasePaginationStateRefreshSuccess;
}
