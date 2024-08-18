import 'package:shared_preferences/shared_preferences.dart';

class UserSessionManager {
  final SharedPreferences sharedPreferences;
  UserSessionManager(this.sharedPreferences);

  Future<bool> getAuthenticationStatus() async {
    return sharedPreferences.getBool('authentication') ?? false;
  }
}
