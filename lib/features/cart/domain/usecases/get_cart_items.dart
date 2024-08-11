
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetCartItems implements UseCase<List<Cart>, NoParams> {
  final CartRepository cartRepository;
  GetCartItems(this.cartRepository);

  @override
  Future<Either<Failure, List<Cart>>> invoke(NoParams params) {
    return cartRepository.getAllItems();
  }
}