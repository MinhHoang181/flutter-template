import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:template/app/app.dart';
import 'package:template/app/dependencies/injectable.dart';
import 'package:template/app/services/app_info.dart';
import 'package:template/core/constants/env_constants.dart';
import 'package:template/core/presentation/widgets/app_text.dart';
import 'package:template/core/theme/app_spacing.dart';
import 'package:template/core/theme/app_theme.dart';
import 'package:template/gen/locale_keys.gen.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context) {
    final String version = getIt<AppInfo>().version(showBuildNumber: getIt<DotEnv>().env[EnvConstants.ENV] != 'PROD');

    return AppText.rich(
      textAlign: TextAlign.center,
      maxLines: 1,
      TextSpan(
        children: [
          TextSpan(
            text: context.text(LocaleKeys.core.version, defaultValue: 'Phiên bản'),
            style: context.textTheme.labelMedium.copyWith(
              fontWeight: FontWeight.w500,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const WidgetSpan(child: AppSpacing.w1),
          TextSpan(
            text: version,
            style: context.textTheme.labelMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
