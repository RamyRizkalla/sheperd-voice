import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shepherd_voice/global/constants/domain_constants.dart';

enum SharedPrefKey { languageCode }

class SharedPrefManager {
  static SharedPreferences? preferences;

  static Future init() async {
    if (preferences != null) return;

    preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  static setValue(SharedPrefKey key, Object value) {
    switch (value.runtimeType) {
      case String _:
        preferences?.setString(key.name, value as String);
        break;
      case bool _:
        preferences?.setBool(key.name, value as bool);
        break;
      case int _:
        preferences?.setInt(key.name, value as int);
        break;
      default:
    }
  }

  static Object getValue(SharedPrefKey key, Object defaultValue) {
    switch (defaultValue.runtimeType) {
      case String _:
        return preferences?.getString(key.name) ?? "";
      case bool _:
        return preferences?.getBool(key.name) ?? false;
      case int _:
        return preferences?.getInt(key.name) ?? 0;
      default:
        return defaultValue;
    }
  }

  static String? stringValue(SharedPrefKey key) {
    return preferences?.getString(key.name);
  }

  static int? intValue(SharedPrefKey key) {
    return preferences?.getInt(key.name);
  }

  static bool? boolValue(SharedPrefKey key) {
    return preferences?.getBool(key.name);
  }

  static setLocale({required Locale locale}) {
    preferences?.setString(
        SharedPrefKey.languageCode.name, locale.languageCode);
  }

  static Locale getLocale() {
    final localeString =
        preferences?.getString(SharedPrefKey.languageCode.name) ??
            Constants.defaultLanguage;
    return Locale(localeString!);
  }
}
