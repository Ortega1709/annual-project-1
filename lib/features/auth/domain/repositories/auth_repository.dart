import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/shared/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User?>> signUp({required User user});
  Future<Either<Failure, User?>> signIn();
}