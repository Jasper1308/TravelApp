import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/constants/languages.dart';
import 'package:travel_app/l10n/app_localizations.dart';
import 'package:travel_app/presentation/providers/app_preferences_provider.dart';
import 'package:travel_app/core/theme/app_theme.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<AppPreferencesState>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.preferences), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(l10n.theme),
              DropdownButton<ThemeMode>(
                value: prefs.themeMode,
                items: ThemeMode.values
                    .map((t) =>
                    DropdownMenuItem(
                      value: t,
                      child: Text(t.name(context)),
                    ))
                    .toList(),
                onChanged: (mode) => mode != null ? prefs.setThemeMode(mode) : null,
              ),
              const SizedBox(height: 16),
              Text(l10n.language),
              DropdownButton<String>(
                value: prefs.language,
                items: availableLanguages.entries
                    .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                    .toList(),
                onChanged: (lang) => lang != null ? prefs.setLanguage(lang) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}