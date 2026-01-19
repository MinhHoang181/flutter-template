part of '../mediator.dart';

abstract class _UnauthorizedEvent implements Command {
  const _UnauthorizedEvent();
}

abstract class _UnauthorizedHandler<E extends _UnauthorizedEvent>
    implements CommandHandler<E> {
  @override
  FutureOr<void> handle(_UnauthorizedEvent request) {
    try {} catch (error, stackTrace) {
      App.logError(
        title: '$_UnauthorizedHandler.handle',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

final class ManualLogoutEvent extends _UnauthorizedEvent {
  const ManualLogoutEvent();
}

final class _ManualLogoutHandler
    extends _UnauthorizedHandler<ManualLogoutEvent> {
  @override
  FutureOr<void> handle(_UnauthorizedEvent request) {
    try {
      super.handle(request);
    } catch (error, stackTrace) {
      App.logError(
        title: '$_ManualLogoutHandler.handle',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

final class PreManualLogoutEvent extends _UnauthorizedEvent {
  const PreManualLogoutEvent();
}

final class _PreManualLogoutHandler
    extends _UnauthorizedHandler<PreManualLogoutEvent> {
  @override
  FutureOr<void> handle(_UnauthorizedEvent request) async {
    try {
      super.handle(request);
    } catch (error, stackTrace) {
      App.logError(
        title: '$_PreManualLogoutHandler.handle',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}

final class DeauthenticateTokenEvent extends _UnauthorizedEvent {
  const DeauthenticateTokenEvent();
}

final class _UnauthorizedTokenHandler
    extends _UnauthorizedHandler<DeauthenticateTokenEvent> {
  @override
  FutureOr<void> handle(_UnauthorizedEvent request) {
    try {
      super.handle(request);

      const RootRoute().go(App.context);
    } catch (error, stackTrace) {
      App.logError(
        title: '$_UnauthorizedTokenHandler.handle',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
