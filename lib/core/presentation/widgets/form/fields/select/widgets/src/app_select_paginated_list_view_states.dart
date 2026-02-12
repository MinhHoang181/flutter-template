part of '../app_select_paginated_list_view.dart';

class _AppSelectPaginatedListViewError extends StatelessWidget {
  const _AppSelectPaginatedListViewError({required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: Center(
        child: AppText(
          error,
          style: AppFonts.size18Semi,
          textAlign: TextAlign.center,
          maxLines: null,
        ),
      ),
    );
  }
}

class _AppSelectPaginatedListViewEmpty extends StatelessWidget {
  const _AppSelectPaginatedListViewEmpty({this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.s4),
      child: Center(
        child: AppText(
          message ??
              context.text(
                LocaleKeys.core.empty,
                defaultValue: 'Không có dữ liệu',
              ),
          style: AppFonts.size18Semi,
          textAlign: TextAlign.center,
          maxLines: null,
        ),
      ),
    );
  }
}

class _AppSelectPaginatedListViewLoading extends StatelessWidget {
  const _AppSelectPaginatedListViewLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(AppSpacing.s4),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
