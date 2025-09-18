// lib/core/localization/app_localizations.dart
import 'package:flutter/foundation.dart' show SynchronousFuture, debugPrint;
import 'package:flutter/widgets.dart';
import 'l10n_utils.dart';


/// JSON-backed localization with flattened cache + fallback to English.
class AppLocalizations {
  AppLocalizations(this.locale);
  final Locale locale;

  static const supportedLocales = <Locale>[
    Locale('en'), // English
    Locale('ar'), // Arabic
    Locale('fr'), // French
  ];

  static const String assetDir = 'assets/i18n';

  /// In-memory cache: langCode -> { "home.title": "..." }
  static final Map<String, Map<String, String>> _cache = {};

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;

  static AppLocalizations? maybeOf(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const LocalizationsDelegate<AppLocalizations> delegate = _L10nDelegate();

  /// Ensure a language is loaded into cache once.
  static Future<void> _ensureLoaded(String code) async {
    if (_cache.containsKey(code)) return;
    try {
      _cache[code] = await L10nUtils.loadFlatten(assetsDir: assetDir, code: code);
    } catch (_) {
      _cache[code] = <String, String>{}; // prevent repeated I/O on error
    }
  }

  /// O(1) lookup with English fallback; logs missing keys in debug.
  String t(String key) {
    final lang = locale.languageCode;
    final map = _cache[lang] ?? _cache['en'] ?? const <String, String>{};
    final value = map[key];

    assert(() {
      if (value == null) debugPrint('⚠️ [i18n] Missing key "$key" for "$lang"');
      return true;
    }());

    return value ?? key;
  }

  String call(String key) => t(key);

  /// Namespace helper: final h = t.ns('home'); h('title')
  StringsNS ns(String namespace) => StringsNS(this, namespace);
}

class StringsNS {
  const StringsNS(this._strings, this._ns);
  final AppLocalizations _strings;
  final String _ns;
  String call(String key) => _strings.t('$_ns.$key');
}

class _L10nDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _L10nDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final code = locale.languageCode;

    // If current lang + English are cached, return synchronously (fast path)
    if (AppLocalizations._cache.containsKey(code) &&
        AppLocalizations._cache.containsKey('en')) {
      return SynchronousFuture(AppLocalizations(locale));
    }

    // Load current lang + English fallback once
    await AppLocalizations._ensureLoaded(code);
    if (code != 'en') await AppLocalizations._ensureLoaded('en');

    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_L10nDelegate old) => false;
}
