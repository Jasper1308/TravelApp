import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/core/constants/languages.dart';
import 'package:travel_app/providers/app_preferences_provider.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    final preferencesState = Provider.of<AppPreferencesState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Preferências'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Tema'),
              DropdownButton<ThemeMode>(
                value: preferencesState.themeMode,
                items: ThemeMode.values
                    .map(
                      (themeMode) => DropdownMenuItem(
                        value: themeMode,
                        child: Text(themeMode.toString()),
                      ),
                    )
                    .toList(),
                onChanged: (ThemeMode? themeMode) {
                  if (themeMode != null) {
                    preferencesState.setThemeMode(themeMode);
                  }
                },
              ),
              Text('Idioma'),
              DropdownButton<String>(
                value: preferencesState.language,
                items: availableLanguages.entries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (String? language) {
                  if (language != null) {
                    preferencesState.setLanguage(language);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
