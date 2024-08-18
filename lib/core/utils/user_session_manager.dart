import 'package:shared_preferences/shared_preferences.dart';

class UserSessionManager {
  final SharedPreferences sharedPreferences;
  UserSessionManager(this.sharedPreferences);

  static Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
