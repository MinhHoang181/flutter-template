import 'package:core_widget/core_widget.dart';
import 'package:icon/icon.dart';
import 'package:injectable/injectable.dart';

import '../app.dart';
import '../services/app/app_service.dart';
import '../services/auth/auth_service.dart';
import 'configure_dependencies.config.dart';

@InjectableInit()
Future<void> configureDependencies() async {
  await getIt.init();

  coreWidgetLogger = CoreWidgetLogger.custom(
    logDebug: (message) {
      App.logDebug(title: 'CoreWidget', message: message);
    },
    logError: (error, stackTrace) {
      App.logError(title: 'CoreWidget', error: error, stackTrace: stackTrace);
    },
  );

  iconLogger = IconLogger.custom(
    logDebug: (message) {
      App.logDebug(title: 'Icon', message: message);
    },
    logError: (error, stackTrace) {
      App.logError(title: 'Icon', error: error, stackTrace: stackTrace);
    },
  );
}

Future<void> initializeApp() async {
  if (initializeAppCompleter.isCompleted) return;

  await Future.wait([
    getIt<AppService>().initialize(),
    getIt<AuthService>().initialize().then((status) async {
      if (status == AuthStatus.authorized) {
        // initialize repositories need auth
      }
    }),

    // initialize repositories
  ]);

  initializeAppCompleter.complete(null);
}
