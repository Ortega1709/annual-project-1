part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class LoadingAuthState extends AuthState {
  const LoadingAuthState();

  @override
  List<Object> get props => [];
}

final class UserSessionAuthenticatedState extends AuthState {}
final class UserSessionUnAuthenticatedState extends AuthInitial {}

final class SignInWithGoogleErrorState extends AuthState {
  final String error;
  const SignInWithGoogleErrorState(this.error);

  @override
  List<Object> get props => [error];
}

final class SignInWithGoogleSuccessState extends AuthState {
  final User? user;
  const SignInWithGoogleSuccessState(this.user);

  @override
  List<Object> get props => [];
}

final class RedirectToSignUpState extends AuthState {}

final class SignUpWithGoogleSuccessState extends AuthState {
  final User user;
  const SignUpWithGoogleSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

final class SignUpWithGoogleErrorState extends AuthState {
  final String error;
  const SignUpWithGoogleErrorState(this.error);

  @override
  List<Object> get props => [error];
}

