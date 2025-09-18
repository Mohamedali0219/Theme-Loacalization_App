# Flutter Starter — Themes + i18n + Persistence

Lightweight Flutter starter with **Light/Dark/System themes**, **JSON-based localization**, and **persistent settings** (theme & language) via `SharedPreferences`.  
No external state-management—just a tiny `AppScope` + controllers.

## Features
- 🎨 **Themes**: Light / Dark / System (Material 3, `ColorScheme.fromSeed`)
- 🌍 **Localization**: External JSON (`assets/i18n/en|ar|fr.json`), supports deep nesting
- 💾 **Persistence**: Remembers theme & language across restarts
- ⚡ **Performance**: Flattened i18n map (O(1) lookups), single `MaterialApp` rebuild

## Quick Start

flutter pub get
flutter run
