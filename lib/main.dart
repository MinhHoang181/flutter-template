import 'package:core_extension/core_extension.dart';
import 'package:core_widget/core_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/app.dart';
import 'app/dependencies/configure_dependencies.dart';
import 'app/mediator/mediator.dart';
import 'app/services/app_localization.dart';
import 'app/services/app_theme_manager.dart';
import 'core/constants/env_constants.dart';

void main() async {
  await _preRunApp();

  runApp(_app());
}

Widget _app() {
  return const AppThemeManager(
    child: AppLocalization(
      child: _App(),
    ),
  );
}

Future<void> _preRunApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await configureDependencies();
  configureMediator();

  await AppThemeManager.ensureInitialized();
  await AppLocalization.ensureInitialized();
}

Future<void> initializeApp() async {
  if (initializeAppCompleter.isCompleted) return;
  initializeAppCompleter.complete(null);
}

class _App extends StatefulWidget {
  const _App();

  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> with WidgetsBindingObserver {
  late final String _env;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _env = getIt
        .get<DotEnv>()
        .env
        .getString(EnvConstants.ENV)
        .toUpperCase()
        .trim();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
      // App is resumed
      case AppLifecycleState.paused:
      // App is paused
      case AppLifecycleState.inactive:
      // App is inactive (e.g., during a phone call)
      case AppLifecycleState.detached:
      // App is detached from the view hierarchy
      case AppLifecycleState.hidden:
      // App is hidden (e.g., when the user switches to another app)
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      isShow: _env != 'PROD',
      env: _env,
      child: MaterialApp.router(
        // app theme manager
        theme: context.lightTheme,
        darkTheme: context.darkTheme,
        themeMode: context.themeMode,
        // app localization
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        // app router
        routeInformationProvider: App.router.routeInformationProvider,
        routeInformationParser: App.router.routeInformationParser,
        routerDelegate: App.router.routerDelegate,
        //--
        debugShowCheckedModeBanner: false,
        builder: _customBuilder,
      ),
    );
  }

  Widget _customBuilder(BuildContext context, Widget? child) {
    // check null
    child ??= const SizedBox.shrink();

    // unfocus when tap
    child = GestureDetector(
      onTap: FocusManager.instance.primaryFocus?.unfocus,
      child: child,
    );

    // no scaling text
    return MediaQuery.withNoTextScaling(child: child);
  }
}
