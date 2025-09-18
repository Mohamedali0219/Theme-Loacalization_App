import 'package:flutter/material.dart';

import '../../../core/widgets/app_scope.dart';
import '../../core/constants/theme_choice.dart';
import '../../core/localization/app_localizations.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    //final c = t.ns('common');

    return Scaffold(
      //appBar: AppBar(title: Text(c('settings'))),
      appBar: AppBar(title: Text(t('common.settings'))),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            _ThemeSection(),
            SizedBox(height: 16),
            _LanguageSection(),
          ],
        ),
      ),
    );
  }
}

class _ThemeSection extends StatelessWidget {
  const _ThemeSection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final theme = AppScope.of(context).theme; // ThemeController

    return AnimatedBuilder(
      animation: theme,
      builder: (context, _) {
        final selected = <ThemeChoice>{theme.choice};
        return Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t('common.theme'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                SegmentedButton<ThemeChoice>(
                  segments: [
                    ButtonSegment(
                      value: ThemeChoice.system,
                      label: Text(t('common.system')),
                    ),
                    ButtonSegment(
                      value: ThemeChoice.light,
                      label: Text(t('common.light')),
                    ),
                    ButtonSegment(
                      value: ThemeChoice.dark,
                      label: Text(t('common.dark')),
                    ),
                  ],
                  selected: selected,
                  onSelectionChanged: (set) => theme.choice = set.first,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageSection extends StatelessWidget {
  const _LanguageSection();

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final c = t.ns('common');
    final locale = AppScope.of(context).locale; // LocaleController

    return AnimatedBuilder(
      animation: locale,
      builder: (context, _) {
        final current = locale.locale?.languageCode ?? 'system';

        return Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c('language'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('English'),
                      selected: current == 'en',
                      onSelected: (_) => locale.setCode('en'),
                    ),
                    ChoiceChip(
                      label: const Text('العربية'),
                      selected: current == 'ar',
                      onSelected: (_) => locale.setCode('ar'),
                    ),
                    ChoiceChip(
                      label: const Text('Français'),
                      selected: current == 'fr',
                      onSelected: (_) => locale.setCode('fr'),
                    ),
                    ChoiceChip(
                      label: Text(t('common.follow_system')),
                      selected: current == 'system',
                      onSelected: (_) => locale.setCode('system'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
