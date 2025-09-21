import 'package:flutter/material.dart';
import 'package:template/app/app.dart';
import 'package:template/app/route/data/app_transition_page.dart';
import 'package:template/app/route/route.dart';
import 'package:template/core/presentation/widgets/dialog/notify_dialog/app_notify_dialog.dart';

import 'package:template/gen/assets.gen.dart';
import 'package:template/gen/locale_keys.gen.dart';
import 'package:template/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() {
    initializeApp()
      ..then((_) {
        if (!mounted) return;
        RootRoute.custom(transitionType: AppTransitionType.fade).go(context);
      })
      ..onError((error, stackTrace) {
        App.logError(title: '$SplashScreen.initializeApp', error: error, stackTrace: stackTrace);

        App.showDialog(
          barrierDismissible: false,
          child: AppNotifyDialog.error(
            message: App.text(
              LocaleKeys.splash.error_dialog.message,
              defaultValue: 'Khởi tạo ứng dụng thất bại, vui lòng thử lại',
            ),
            primaryLabel: App.text(LocaleKeys.splash.error_dialog.button.retry, defaultValue: 'Thử lại'),
            onPrimaryPressed: () {
              App.closeDialog();
              _initializeApp();
            },
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Assets.images.launcher.image(fit: BoxFit.none)),
    );
  }
}
