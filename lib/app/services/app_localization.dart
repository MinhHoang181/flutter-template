import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

export 'package:easy_localization/easy_localization.dart' show BuildContextEasyLocalizationExtension;

class AppLocalization extends StatelessWidget {
  const AppLocalization({super.key, required this.child});

  final Widget child;

  static Future<void> ensureInitialized() async {
    EasyLocalization.logger.printer = (object, {level, name, stackTrace}) {};
    await EasyLocalization.ensureInitialized();
  }

  static List<Locale> get supportedLocales => const [Locale('vi'), Locale('en')];

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      path: 'assets/translations',
      supportedLocales: supportedLocales,
      startLocale: supportedLocales.first,
      fallbackLocale: supportedLocales.first,
      useFallbackTranslationsForEmptyResources: true,
      useFallbackTranslations: true,
      saveLocale: true,
      assetLoader: const RootBundleAssetLoader(),
      extraAssetLoaders: [],
      child: child,
    );
  }
}
