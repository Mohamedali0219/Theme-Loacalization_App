// lib/core/localization/l10n_utils.dart
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// Shared helpers for i18n (no caching here)
class L10nUtils {
  /// Flatten nested JSON into dotted keys:
  /// { "home": { "title": "..." } } -> { "home.title": "..." }
  static Map<String, String> flatten(Map<String, dynamic> obj, [String prefix = '']) {
    final out = <String, String>{};
    obj.forEach((k, v) {
      final key = prefix.isEmpty ? k : '$prefix.$k';
      if (v is Map<String, dynamic>) {
        out.addAll(flatten(v, key));
      } else if (v is List) {
        for (var i = 0; i < v.length; i++) {
          final item = v[i];
          if (item is Map<String, dynamic>) {
            out.addAll(flatten(item, '$key.$i'));
          } else {
            out['$key.$i'] = item.toString();
          }
        }
      } else {
        out[key] = v.toString();
      }
    });
    return out;
  }

  /// Load JSON from assets and return flattened map (no cache here)
  static Future<Map<String, String>> loadFlatten({
    required String assetsDir,
    required String code, // 'en' | 'ar' | 'fr' ...
  }) async {
    final s = await rootBundle.loadString('$assetsDir/$code.json');
    final raw = json.decode(s) as Map<String, dynamic>;
    return flatten(raw);
  }
}
