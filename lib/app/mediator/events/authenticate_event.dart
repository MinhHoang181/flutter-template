part of '../mediator.dart';

abstract class _AuthenticateEvent implements Command {
  const _AuthenticateEvent({required this.response});

  final AuthResponse response;
}

abstract class _AuthenticateHandler<E extends _AuthenticateEvent>
    implements CommandHandler<E> {
  @override
  FutureOr<void> handle(covariant _AuthenticateEvent request) async {
    try {} catch (error, stackTrace) {
      App.logError(
        title: '$_AuthenticateHandler.handle',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

final class ManualLoginEvent extends _AuthenticateEvent {
  const ManualLoginEvent({required this.request, required super.response});

  final AuthRequest request;
}

final class _ManualLoginHandler extends _AuthenticateHandler<ManualLoginEvent> {
  @override
  FutureOr<void> handle(ManualLoginEvent request) async {
    try {
      super.handle(request);
    } catch (error, stackTrace) {
      App.logError(
        title: '$_ManualLoginHandler.handle',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

final class RefreshTokenEvent extends _AuthenticateEvent {
  const RefreshTokenEvent({
    required this.refreshToken,
    required super.response,
  });

  final String refreshToken;
}

final class _RefreshTokenHandler
    extends _AuthenticateHandler<RefreshTokenEvent> {}
