import 'package:flutter/material.dart';

class AppPreferencesState extends ChangeNotifier {

}

class ThemePreference {
  static ValueNotifier<Brightness> theme = ValueNotifier(Brightness.light);

  static setTheme() {
    theme.value = WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }
}