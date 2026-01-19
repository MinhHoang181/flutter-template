part of 'detail_cubit.dart';

abstract interface class DetailState<Identity, Detail> {
  const DetailState();

  BaseDetailStateData<Identity, Detail> get data;
}

@Freezed(copyWith: true, genericArgumentFactories: true)
class BaseDetailStateData<Identity, Detail>
    with _$BaseDetailStateData<Identity, Detail> {
  const BaseDetailStateData({required this.identity, required this.detail});

  @override
  final Identity identity;

  @override
  final Detail? detail;
}

@Freezed(
  when: FreezedWhenOptions.all,
  map: FreezedMapOptions.all,
  toJson: false,
  fromJson: false,
  copyWith: false,
  genericArgumentFactories: true,
)
class BaseDetailState<Identity, Detail>
    with _$BaseDetailState<Identity, Detail>
    implements DetailState<Identity, Detail> {
  @Implements<InitialState>()
  const factory BaseDetailState.initial({
    required BaseDetailStateData<Identity, Detail> data,
  }) = BaseDetailStateInitial;

  @Implements<LoadingState>()
  const factory BaseDetailState.fetching({
    required BaseDetailStateData<Identity, Detail> data,
  }) = BaseDetailStateFetching;

  @Implements<ErrorState>()
  const factory BaseDetailState.fetchError({
    required BaseDetailStateData<Identity, Detail> data,
    required Exception error,
  }) = BaseDetailStateFetchError;

  const factory BaseDetailState.fetchSuccess({
    required BaseDetailStateData<Identity, Detail> data,
    required Detail detail,
  }) = BaseDetailStateFetchSuccess;

  const BaseDetailState._({required this.data});

  @override
  final BaseDetailStateData<Identity, Detail> data;
}
