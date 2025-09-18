import 'package:flutter/widgets.dart';
import 'package:app_theme_localization/features/settings/logic/locale_controller.dart';
import 'package:app_theme_localization/features/settings/logic/theme_controller.dart';

/// Minimal DI via InheritedWidget to expose ThemeController & LocaleController.
class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.theme,
    required this.locale,
    required super.child,
  });

  final ThemeController theme;
  final LocaleController locale;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope == null) {
      throw FlutterError('AppScope not found. Wrap your app with AppScope in main.dart.');
    }
    return scope;
  }

  @override
  bool updateShouldNotify(covariant AppScope old) =>
      theme != old.theme || locale != old.locale;
}
