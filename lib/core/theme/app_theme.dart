import 'package:flutter/material.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  );
}

extension ThemeModeExtension on ThemeMode {
  String name(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    switch (this) {
      case ThemeMode.system:
        return locale.themeSystem;
      case ThemeMode.light:
        return locale.themeLight;
      case ThemeMode.dark:
        return locale.themeDark;
    }
  }
}
