import 'package:e_commerce/core/utils/user_session_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSessionCubit extends Cubit<bool> {
  final UserSessionManager userSessionManager;
  UserSessionCubit(this.userSessionManager) : super(false);

  Future<void> checkSession() async {
    bool authenticated = await userSessionManager.getAuthenticationStatus();
    emit(authenticated);
  }
}
