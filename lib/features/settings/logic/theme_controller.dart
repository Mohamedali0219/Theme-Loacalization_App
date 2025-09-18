import 'dart:ui' show PlatformDispatcher;
import 'package:flutter/material.dart';

import '../../../core/constants/theme_choice.dart';
import '../../../core/services/settings_store.dart';

/// Controls app theme (System/Light/Dark). Persists to SharedPreferences.
class ThemeController extends ChangeNotifier {
  ThemeController(this._store) {
    _choice = _store.readTheme();
    _prev = PlatformDispatcher.instance.onPlatformBrightnessChanged;
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      if (_choice == ThemeChoice.system) notifyListeners();
    };
  }

  final SettingsStore _store;
  late ThemeChoice _choice;
  ThemeChoice get choice => _choice;

  set choice(ThemeChoice c) {
    if (_choice == c) return;
    _choice = c;
    _store.writeTheme(c);
    notifyListeners();
  }

  ThemeMode get themeMode => _choice.toThemeMode();

  VoidCallback? _prev;
  @override
  void dispose() {
    PlatformDispatcher.instance.onPlatformBrightnessChanged = _prev;
    super.dispose();
  }
}
