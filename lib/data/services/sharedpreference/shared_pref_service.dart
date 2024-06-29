import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _loggedInKey = 'isLoggedIn';
  static const String _phoneNumberKey = 'phoneNumber';

  static Future<void> saveLoggedIn(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, isLoggedIn);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loggedInKey) ?? false;
  }

  static Future<void> savePhoneNumber(String phoneNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, phoneNumber);
  }

  static Future<String?> getPhoneNumber() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_phoneNumberKey);
  }

  static Future<void> clearLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInKey);
    await prefs.remove(_phoneNumberKey);
  }
}
