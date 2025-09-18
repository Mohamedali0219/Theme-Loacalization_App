// lib/core/services/settings_store.dart
import 'package:flutter/material.dart';
import '../constants/theme_choice.dart';
import 'prefs.dart';

/// Typed read/write for user settings (theme + locale).
class SettingsStore {
  SettingsStore(this._prefs);
  final Prefs _prefs;

  static const _kTheme = 'settings.theme';
  static const _kLang  = 'settings.lang';

  // THEME
  ThemeChoice readTheme() {
    switch (_prefs.getString(_kTheme)) {
      case 'light': return ThemeChoice.light;
      case 'dark':  return ThemeChoice.dark;
      case 'system':
      default:      return ThemeChoice.system;
    }
  }

  Future<void> writeTheme(ThemeChoice value) async {
    await _prefs.setString(_kTheme, value.key());
  }

  // LOCALE
  Locale? readLocale() {
    final code = _prefs.getString(_kLang);
    if (code == null || code == 'system') return null; // null => follow device
    return Locale(code);
  }

  Future<void> writeLocale(Locale? value) async {
    await _prefs.setString(_kLang, value?.languageCode ?? 'system');
  }
}
