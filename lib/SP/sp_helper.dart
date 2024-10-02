import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SpHelper {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  static Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<List<String>?> getStringList(String key) async {
    return _prefs.getStringList(key);
  }

  static Future<void> setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }
}