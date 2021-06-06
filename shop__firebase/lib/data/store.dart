import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Store {
  static Future<SharedPreferences> _getInstance() async {
    return SharedPreferences.getInstance();
  }

  static Future<void> saveString(String key, String value) async {
    SharedPreferences store = await _getInstance();
    await store.setString(key, value);
  }

  static Future<void> saveMap(String key, Map<String, dynamic> map) async {
    SharedPreferences store = await _getInstance();
    await store.setString(key, jsonEncode(map));
  }

  static Future<String> getString(String key) async {
    SharedPreferences store = await _getInstance();
    return store.getString(key);
  }

  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      Map<String, dynamic> map = jsonDecode(await getString(key));
      return map;
    } catch (e) {
      return null;
    }
  }

  static Future<void> remove(String key) async {
    SharedPreferences store = await _getInstance();
    return store.remove(key);
  }
}
