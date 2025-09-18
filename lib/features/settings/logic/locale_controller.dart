import 'package:flutter/material.dart';
import '../../../core/services/settings_store.dart';

/// Controls app locale (null => follow system). Persists to SharedPreferences.
class LocaleController extends ChangeNotifier {
  LocaleController(this._store) {
    _locale = _store.readLocale(); // null means follow device language
  }

  final SettingsStore _store;
  Locale? _locale;
  Locale? get locale => _locale;

  set locale(Locale? newLocale) {
    if (_locale == newLocale) return;
    _locale = newLocale;
    _store.writeLocale(newLocale);
    notifyListeners();
  }

  void setCode(String codeOrSystem) {
    locale = codeOrSystem == 'system' ? null : Locale(codeOrSystem);
  }
}
