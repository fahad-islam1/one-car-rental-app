import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _loggedInKey = 'isLoggedIn';

  static Future<void> saveLoggedIn(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }
  static Future<void> clearLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInKey);
  }
}
