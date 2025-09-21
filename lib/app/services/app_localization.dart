import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template/gen/assets.gen.dart';

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
      path: Assets.translations.path,
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
