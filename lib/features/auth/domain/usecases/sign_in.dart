import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/shared/entities/user.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignIn implements UseCase<User?, NoParams> {
  final AuthRepository authRepository;
  SignIn(this.authRepository);

  @override
  Future<Either<Failure, User?>> invoke(NoParams params) async {
    return await authRepository.signIn();
  }
  
}