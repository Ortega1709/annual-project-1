import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:e_commerce/features/cart/domain/entities/make_order.dart';
import 'package:e_commerce/features/cart/domain/repositories/commande_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddOrder implements UseCase<String?, AddOrderParams> {
  final CommandeRepository commandeRepository;
  AddOrder(this.commandeRepository);

  @override
  Future<Either<Failure, String?>> invoke(AddOrderParams params) {
    return commandeRepository.makeOrder(
      makeOrder: MakeOrder(
        references: params.references,
        userId: params.userId,
        total: params.total,
        cart: params.cart,
      ),
    );
  }
}

class AddOrderParams {
  final String references;
  final String userId;
  final double total;
  final List<Cart> cart;

  AddOrderParams({
    required this.references,
    required this.userId,
    required this.total,
    required this.cart,
  });
}
