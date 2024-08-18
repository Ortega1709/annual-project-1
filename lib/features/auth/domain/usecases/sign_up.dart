import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/shared/entities/user.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUp implements UseCase<User?, SignUpParams> {
  final AuthRepository authRepository;
  SignUp(this.authRepository);

  @override
  Future<Either<Failure, User?>> invoke(SignUpParams params) async {
    return await authRepository.signUp(
      user: User(
        id: 'id',
        email: params.email,
        name: params.name,
        adresse: params.addresse,
        commune: params.commune,
        ville: params.ville,
        created: 'created'
      ),
    );
  }
}

class SignUpParams {
  final String email;
  final String name;
  final String addresse;
  final String commune;
  final String ville;

  const SignUpParams({
    required this.email,
    required this.name,
    required this.ville,
    required this.addresse,
    required this.commune,
  });
  
}
