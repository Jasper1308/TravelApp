import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferencesState extends ChangeNotifier {
  static const String _themeModeKey = 'themeMode';
  static const String _languageKey = 'language';

  ThemeMode _themeMode = ThemeMode.system;
  String _language = 'en';

  ThemeMode get themeMode => _themeMode;

  String get language => _language;

  AppPreferencesState() {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final int? themeModeValue = prefs.getInt(_themeModeKey);
    if (themeModeValue != null) {
      _themeMode = ThemeMode.values[themeModeValue];
    } else {
      _themeMode = ThemeMode.system;
    }

    final String? languageValue = prefs.getString(_languageKey);
    if (languageValue != null) {
      _language = languageValue;
    } else {
      _language = PlatformDispatcher.instance.locale.languageCode;
    }

    notifyListeners();
  }

  void setThemeMode(ThemeMode themeMode) {
    if (_themeMode == themeMode) return;
    _themeMode = themeMode;
    _saveThemeMode();
    notifyListeners();
  }

  void _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, _themeMode.index);
  }

  void setLanguage(String language) {
    if (_language == language) return;
    _language = language;
    _saveLanguage();
    notifyListeners();
  }

  void _saveLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, _language);
  }
}
