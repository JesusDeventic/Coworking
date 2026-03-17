import 'package:shared_preferences/shared_preferences.dart';

/// Preferencias de tema e idioma (persistidas en disco).
class UserPreferences {
  static const _keyTheme = 'filmoly_theme_dark';
  static const _keyLanguage = 'filmoly_language';
  static const _keyWeekStart = 'filmoly_week_start';
  static const _keyDateFormat = 'filmoly_date_format';

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  Future<void> setThemeApp(bool isDark) async {
    final prefs = await _prefs;
    await prefs.setBool(_keyTheme, isDark);
  }

  Future<bool?> getThemeApp() async {
    final prefs = await _prefs;
    return prefs.getBool(_keyTheme);
  }

  Future<void> setLanguage(String languageCode) async {
    final prefs = await _prefs;
    await prefs.setString(_keyLanguage, languageCode);
  }

  Future<String?> getLanguage() async {
    final prefs = await _prefs;
    return prefs.getString(_keyLanguage);
  }

  Future<void> setWeekStart(String value) async {
    final prefs = await _prefs;
    await prefs.setString(_keyWeekStart, value);
  }

  Future<String?> getWeekStart() async {
    final prefs = await _prefs;
    return prefs.getString(_keyWeekStart);
  }

  Future<void> setDateFormat(String value) async {
    final prefs = await _prefs;
    await prefs.setString(_keyDateFormat, value);
  }

  Future<String?> getDateFormat() async {
    final prefs = await _prefs;
    return prefs.getString(_keyDateFormat);
  }
}
