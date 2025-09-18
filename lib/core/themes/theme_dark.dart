// lib/core/themes/theme_dark.dart
import 'package:flutter/material.dart';

ThemeData buildDarkTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.dark,
  ),
  visualDensity: VisualDensity.compact,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);
