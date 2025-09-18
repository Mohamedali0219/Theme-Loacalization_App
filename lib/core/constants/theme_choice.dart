// lib/core/constant/theme_choice.dart
import 'package:flutter/material.dart';

enum ThemeChoice { system, light, dark }

extension ThemeChoiceX on ThemeChoice {
  ThemeMode toThemeMode() => switch (this) {
        ThemeChoice.system => ThemeMode.system,
        ThemeChoice.light  => ThemeMode.light,
        ThemeChoice.dark   => ThemeMode.dark,
      };

  String key() => switch (this) {
        ThemeChoice.system => 'system',
        ThemeChoice.light  => 'light',
        ThemeChoice.dark   => 'dark',
      };
}
