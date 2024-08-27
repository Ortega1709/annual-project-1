import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:e_commerce/features/cart/domain/repositories/commande_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetOrderByUserId implements UseCase<List<Orderl>, GetOrderByUserIdParams> {
  final CommandeRepository commandeRepository;
  GetOrderByUserId(this.commandeRepository);

  @override
  Future<Either<Failure, List<Orderl>>> invoke(GetOrderByUserIdParams params) async {
    return commandeRepository.getAllOrderByUserId(userId: params.userId);
  }
  
}

class GetOrderByUserIdParams {
  final String userId;

  GetOrderByUserIdParams(this.userId);
}