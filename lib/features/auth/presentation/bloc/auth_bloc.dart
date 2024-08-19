import 'package:e_commerce/core/shared/entities/user.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/auth/domain/usecases/sign_in.dart';
import 'package:e_commerce/features/auth/domain/usecases/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn _signIn;
  final SignUp _signUp;
  final SharedPreferences _sharedPreferences;

  AuthBloc({
    required SignIn signIn,
    required SignUp signUp,
    required SharedPreferences sharedPreferences,
  })  : _signIn = signIn,
        _signUp = signUp,
        _sharedPreferences = sharedPreferences,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthInitial());
    });
    on<SignInWithGoogleEvent>(signInWithGoogle);
    on<SignUpWithGoogleEvent>(signUpWithGoogle);
    on<UserSessionCheckEvent>(userSessionCheck);
  }

  Future<void> signInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _signIn.invoke(NoParams());
    response.fold(
      (err) => emit(SignInWithGoogleErrorState(err.message)),
      (auth) => emit(SignInWithGoogleSuccessState(auth)),
    );
  }

  Future<void> signUpWithGoogle(
    SignUpWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const LoadingAuthState());

    // get our local inforamtions from shared preferences
    final emailStored = _sharedPreferences.getString('email');
    final nameStored = _sharedPreferences.getString('name');

    // check if we have stored email and name in shared preferences
    if (emailStored != null && nameStored != null) {
      final response = await _signUp.invoke(SignUpParams(
          email: emailStored,
          name: nameStored,
          ville: event.ville,
          commune: event.commune,
          addresse: event.adresse));

      response.fold(
        (err) => emit(SignUpWithGoogleErrorState(err.message)),
        (auth) => emit(
          SignUpWithGoogleSuccessState(
            User(
              id: 'id',
              email: 'email',
              name: 'name',
              adresse: 'adresse',
              commune: 'commune',
              ville: 'ville',
              created: 'created',
            ),
          ),
        ),
      );
    }
  }

  Future<void> userSessionCheck(
    UserSessionCheckEvent event,
    Emitter<AuthState> emit,
  ) async {
    debugPrint('UserSessionCheckEvent received');
    bool isAuthenticated = _sharedPreferences.getBool('authentication') ?? false;

    if (isAuthenticated) {
      emit(UserSessionAuthenticatedState());
    } else {
      emit(UserSessionUnAuthenticatedState());
    }
  }
}
