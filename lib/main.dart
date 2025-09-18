import 'package:app_theme_localization/features/settings/logic/locale_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/helpers/echo.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/l10n_health.dart';
import 'core/services/prefs.dart';
import 'core/services/settings_store.dart';
import 'core/widgets/app_scope.dart';

import 'features/settings/logic/theme_controller.dart';
import 'theme_localization_app.dart';

void main() async {
  Echo.info("App started at ${DateTime.now().toIso8601String()}");

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await Prefs.instance();
  final settings = SettingsStore(prefs);

  final themeCtrl = ThemeController(settings); // hydrate
  final localeCtrl = LocaleController(settings); // hydrate

  if (kDebugMode) {
    await L10nHealthCheck.check(
      languages: AppLocalizations.supportedLocales
          .map((l) => l.languageCode)
          .where((c) => c != 'en')
          .toList(),
      base: 'en',
      assetsDir: AppLocalizations.assetDir,
      strict: false, // خليه true في CI لو عايز تفشل الـ build عند النقص
    );
  }
  runApp(
    AppScope(
      theme: themeCtrl,
      locale: localeCtrl,
      child: const ThemeLocalizationApp(),
    ),
  );
}
