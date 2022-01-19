import 'package:shared_preferences/shared_preferences.dart';

class DataPreferences {
  static late SharedPreferences _preferences;
  static Future init() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  static const userKey = 'user';
  static const token = 'token';

  static String getUserName() {
    return _preferences.getString(userKey) ?? '';
  }

  static Future<void> setUserName(String name) async {
    await _preferences.setString(userKey, name);
  }

  static String getToken() {
    return _preferences.getString(token) ?? '';
  }

  static Future<void> setToken(String apiToken) async {
    await _preferences.setString(token, apiToken);
  }
}
