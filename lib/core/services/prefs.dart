// lib/core/services/prefs.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Thin wrapper around SharedPreferences (singleton).
class Prefs {
  Prefs._(this._prefs);
  final SharedPreferences _prefs;

  static Prefs? _instance;
  static Future<Prefs> instance() async {
    if (_instance != null) return _instance!;
    final p = await SharedPreferences.getInstance();
    _instance = Prefs._(p);
    return _instance!;
  }

  // getters
  String? getString(String key) => _prefs.getString(key);
  bool? getBool(String key) => _prefs.getBool(key);
  int? getInt(String key) => _prefs.getInt(key);
  double? getDouble(String key) => _prefs.getDouble(key);
  List<String>? getStringList(String key) => _prefs.getStringList(key);
  Map<String, dynamic>? getJson(String key) {
    final s = _prefs.getString(key);
    if (s == null) return null;
    try { return json.decode(s) as Map<String, dynamic>; } catch (_) { return null; }
  }

  // setters
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);
  Future<bool> setDouble(String key, double value) => _prefs.setDouble(key, value);
  Future<bool> setStringList(String key, List<String> value) => _prefs.setStringList(key, value);
  Future<bool> setJson(String key, Map<String, dynamic> value) =>
      _prefs.setString(key, json.encode(value));

  // maintenance
  Future<bool> remove(String key) => _prefs.remove(key);
  Future<bool> clear() => _prefs.clear();
}
