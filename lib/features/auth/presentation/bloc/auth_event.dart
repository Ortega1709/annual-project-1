part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();

  @override
  List<Object> get props => [];
}

final class ContinueWithoutGoogleAccountEvent extends AuthEvent {
  const ContinueWithoutGoogleAccountEvent();

  @override
  List<Object> get props => [];
}

final class SignUpWithGoogleEvent extends AuthEvent {
  final String ville;
  final String commune;
  final String adresse;

  const SignUpWithGoogleEvent({
    required this.ville,
    required this.commune,
    required this.adresse,
  });

  @override
  List<Object> get props => [ville, commune, adresse];
}
