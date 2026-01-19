import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:template/core/classes/interfaces.dart';
import 'package:template/core/presentation/blocs/state.dart';
import 'package:template/core/utils/async_deduplicator.dart';
import 'package:template/core/utils/either.dart';

part 'detail_state.dart';
part 'detail_cubit.freezed.dart';

abstract class DetailCubit<Identity extends Object, Detail>
    extends Cubit<DetailState<Identity, Detail>> {
  DetailCubit({
    required Identity identity,
    required Detail? data,
    this.iRefresh,
  }) : super(
         BaseDetailState.initial(
           data: BaseDetailStateData(identity: identity, detail: data),
         ),
       ) {
    _refreshSubscription = iRefresh?.getRefreshStream().listen((data) {
      final detail = state.data.detail;
      if (data != null &&
          detail != null &&
          data is IEntity<Identity, Detail> &&
          data.isSame(detail)) {
        fetchDetail();
      }
    });
  }

  @protected
  final IRefresh<Detail>? iRefresh;

  Identity get identity => state.data.identity;

  Detail? get data => state.data.detail;

  final AsyncDeduplicator _fetchDetailDeduplicator = AsyncDeduplicator();

  StreamSubscription<Detail?>? _refreshSubscription;

  @override
  Future<void> close() {
    _refreshSubscription?.cancel();
    return super.close();
  }

  @protected
  Future<Either<Exception, Detail>> loadDetail();

  Future<void> fetchDetail() async {
    return _fetchDetailDeduplicator.fetch(() async {
      if (isClosed) return;

      emit(BaseDetailState.fetching(data: state.data));

      final result = await loadDetail();

      if (isClosed) return;

      result.fold(
        (error) {
          emit(BaseDetailState.fetchError(data: state.data, error: error));
        },
        (detail) {
          emit(
            BaseDetailState.fetchSuccess(
              data: state.data.copyWith(detail: detail),
              detail: detail,
            ),
          );
        },
      );
    });
  }
}
