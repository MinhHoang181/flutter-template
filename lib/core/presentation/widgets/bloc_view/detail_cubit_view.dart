import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/app/app.dart';
import 'package:template/core/presentation/blocs/state.dart';
import 'package:template/core/presentation/widgets/app_button/app_button.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_fonts.dart';
import 'package:template/core/theme/app_spacing.dart';
import 'package:template/gen/locale_keys.gen.dart';

import '../../blocs/detail_cubit/detail_cubit.dart';

typedef DetailCubitViewBuilder<Detail> =
    Widget Function(BuildContext context, Detail detail);

typedef DetailCubitViewLoadingBuilder = Widget Function(BuildContext context);

typedef DetailCubitViewErrorBuilder<Identity, Detail> =
    Widget Function(
      BuildContext context,
      DetailState<Identity, Detail> state,
      Exception error,
    );

typedef DetailCubitViewErrorCallback<Identity, Detail> =
    void Function(
      BuildContext context,
      DetailState<Identity, Detail> state,
      Exception error,
    );

class DetailCubitView<Identity extends Object, Detail> extends StatefulWidget {
  const DetailCubitView({
    super.key,
    required this.cubit,
    required this.builder,
    this.loadingBuilder,
    this.errorBuilder,
    this.onError,
  });

  final DetailCubit<Identity, Detail> cubit;

  final DetailCubitViewBuilder<Detail> builder;

  final DetailCubitViewLoadingBuilder? loadingBuilder;

  final DetailCubitViewErrorBuilder<Identity, Detail>? errorBuilder;

  final DetailCubitViewErrorCallback<Identity, Detail>? onError;

  @override
  DetailCubitViewState<Identity, Detail> createState() =>
      DetailCubitViewState<Identity, Detail>();
}

class DetailCubitViewState<Identity extends Object, Detail>
    extends State<DetailCubitView<Identity, Detail>> {
  late final DetailCubit<Identity, Detail> cubit;
  @override
  void initState() {
    super.initState();
    cubit = widget.cubit;

    cubit.fetchDetail();
  }

  void _listener(BuildContext context, DetailState<Identity, Detail> state) {
    if (state is BaseDetailStateFetchError<Identity, Detail>) {
      widget.onError?.call(context, state, state.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<
      DetailCubit<Identity, Detail>,
      DetailState<Identity, Detail>
    >(
      bloc: cubit,
      listener: _listener,
      buildWhen: (previous, current) {
        if (previous.data.detail != current.data.detail) return true;
        if (current.data.detail == null && current is ErrorState) return true;
        return false;
      },
      builder: (context, state) {
        final detail = state.data.detail;

        if (detail == null) {
          if (state is ErrorState) {
            return _errorBuilder(context, state, (state as ErrorState).error);
          }

          return _loadingBuilder(context);
        }

        return _detailBuilder(context, detail);
      },
    );
  }

  Widget _detailBuilder(BuildContext context, Detail detail) {
    return widget.builder(context, detail);
  }

  Widget _loadingBuilder(BuildContext context) {
    return widget.loadingBuilder?.call(context) ??
        const Center(child: CircularProgressIndicator());
  }

  Widget _errorBuilder(
    BuildContext context,
    DetailState<Identity, Detail> state,
    Exception error,
  ) {
    return widget.errorBuilder?.call(context, state, error) ??
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.s4,
            children: [
              AppText(
                error.toString(),
                style: AppFonts.size16Regular,
                maxLines: null,
                textAlign: TextAlign.center,
              ),
              AppButton.outlined(
                label: context.text(
                  LocaleKeys.core.retry,
                  defaultValue: 'Thử lại',
                ),
                size: AppButtonSize.medium,
                onPressed: cubit.fetchDetail,
              ),
            ],
          ),
        );
  }
}
