abstract interface class InitialState {}

abstract interface class LoadingState {}

abstract interface class ErrorState {
  ErrorState({required this.error});

  final Exception error;
}
