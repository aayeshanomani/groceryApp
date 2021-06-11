import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;
String username = "";

class Helper {
  static String loggedInKey = "LOGGEDINKEY";
  static String usernameKey = "USERNAMEKEY";

  static Future<bool> saveUserloggedIn(bool isUserLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setBool(loggedInKey, isUserLoggedIn);
  }

  static Future<bool> getUserloggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(loggedInKey);
  }

  static Future<bool> saveUsername(String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return await pref.setString(usernameKey, username);
  }

  static Future<String> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(usernameKey);
  }
}
