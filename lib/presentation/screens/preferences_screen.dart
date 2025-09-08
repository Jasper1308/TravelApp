import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/constants/languages.dart';
import 'package:travel_app/presentation/providers/app_preferences_provider.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<AppPreferencesState>();

    return Scaffold(
      appBar: AppBar(title: const Text('Preferências'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Tema'),
            DropdownButton<ThemeMode>(
              value: prefs.themeMode,
              items: ThemeMode.values
                  .map((t) =>
                  DropdownMenuItem(value: t, child: Text(t.toString())))
                  .toList(),
              onChanged: (mode) => mode != null ? prefs.setThemeMode(mode) : null,
            ),
            const SizedBox(height: 16),
            const Text('Idioma'),
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
    );
  }
}
