import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteItemToCart implements UseCase<void, DeleteItemToCartParams> {
  final CartRepository cartRepository;
  DeleteItemToCart(this.cartRepository);

  @override
  Future<Either<Failure, void>> invoke(DeleteItemToCartParams params) {
    return cartRepository.deleteItemToCart(params.index);
  }

}

class DeleteItemToCartParams {
  final int index;
  DeleteItemToCartParams({required this.index});
}
