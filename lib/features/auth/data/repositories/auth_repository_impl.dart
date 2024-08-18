import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/shared/entities/user.dart';
import 'package:e_commerce/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:e_commerce/features/auth/data/models/user_model.dart';
import 'package:e_commerce/features/auth/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<Either<Failure, User?>> signIn() async {
    try {
      return right(await authRemoteDatasource.signIn());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User?>> signUp({required User user}) async {
    try {
      return right(
        await authRemoteDatasource.signUp(
          userModel: UserModel(
            id: user.id,
            email: user.email,
            name: user.name,
            adresse: user.adresse,
            commune: user.commune,
            ville: user.ville,
            created: user.created,
          ),
        ),
      );
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
