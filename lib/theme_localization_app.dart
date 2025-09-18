import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/localization/app_localizations.dart';
import 'core/themes/theme_dark.dart';
import 'core/themes/theme_light.dart';
import 'core/widgets/app_scope.dart';
import 'features/settings/setting_screen.dart';

class ThemeLocalizationApp extends StatelessWidget {
  const ThemeLocalizationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final scope = AppScope.of(context);
    final merged = Listenable.merge([scope.theme, scope.locale]);

    return AnimatedBuilder(
      animation: merged,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App',
          // THEMES
          themeMode: scope.theme.themeMode,
          theme: buildLightTheme(),
          darkTheme: buildDarkTheme(),
          // I18N
          locale: scope.locale.locale, // null => follow system
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const SettingsScreen(),
        );
      },
    );
  }
}
