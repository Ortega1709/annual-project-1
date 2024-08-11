 
import 'package:fpdart/fpdart.dart';

import '../errors/failure.dart';

/// Define a generic use case
/// [S] The type of success data returned by use case
/// [P] The type of params required by use case
abstract interface class UseCase<S, P> {
  Future<Either<Failure, S>> invoke(P params);
}


class NoParams {}