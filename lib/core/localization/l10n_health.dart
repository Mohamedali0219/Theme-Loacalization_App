// lib/core/localization/l10n_health.dart
import 'package:flutter/foundation.dart' show kDebugMode, debugPrint;
import 'package:flutter/widgets.dart' show FlutterError;
import 'l10n_utils.dart';

/// Compares each locale's keys against the base (default 'en') and logs diffs.
class L10nHealthCheck {
  static Future<void> check({
    required List<String> languages, // e.g. ['ar','fr']
    String assetsDir = 'assets/i18n',
    String base = 'en',
    int sample = 20,
    bool strict = false, // true in CI to fail build on mismatch
  }) async {
    if (!kDebugMode) return; // dev-only

    Future<Map<String, String>> load(String code) async {
      try {
        return await L10nUtils.loadFlatten(assetsDir: assetsDir, code: code);
      } catch (e) {
        debugPrint('❌ L10n: failed to load $assetsDir/$code.json: $e');
        return {};
      }
    }

    final langs = {...languages, base}.toList();
    final maps = <String, Map<String, String>>{};
    for (final code in langs) {
      maps[code] = await load(code);
    }

    final baseKeys = maps[base]!.keys.toSet();
    debugPrint('—— L10n Health Check —————————————');
    debugPrint(
      'Base: $base (${baseKeys.length}) • Langs: ${languages.join(", ")}',
    );

    var hasIssues = false;
    for (final code in languages) {
      final keys = maps[code]!.keys.toSet();
      final missing = baseKeys.difference(keys);
      final extras = keys.difference(baseKeys);

      if (missing.isEmpty && extras.isEmpty) {
        debugPrint('✅ $code — OK (${keys.length} keys)');
        continue;
      }

      hasIssues = true;
      debugPrint(
        '⚠️  $code — Missing: ${missing.length}, Extra: ${extras.length}',
      );
      if (missing.isNotEmpty) {
        debugPrint('   ↳ missing (sample): ${missing.take(sample).join(', ')}');
      }
      if (extras.isNotEmpty) {
        debugPrint('   ↳ extra (sample): ${extras.take(sample).join(', ')}');
      }
    }

    if (strict && hasIssues) {
      throw FlutterError('L10n health check failed. See logs above.');
    }
    debugPrint('———————————————————————————————');
  }
}
