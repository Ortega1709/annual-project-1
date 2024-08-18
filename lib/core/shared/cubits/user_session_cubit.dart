import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSessionCubit extends Cubit<bool> {
  final SharedPreferences sharedPreferences;
  UserSessionCubit(this.sharedPreferences) : super(false);

  Future<void> checkSession() async {
    
  }
}