// lib/core/themes/theme_light.dart
import 'package:flutter/material.dart';

ThemeData buildLightTheme() => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.light,
  ),
  visualDensity: VisualDensity.compact,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
  ),
);
