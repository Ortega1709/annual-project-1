import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class AddItemToCart implements UseCase<List<Cart>, AddItemToCartParams> {
  final CartRepository cartRepository;

  AddItemToCart(this.cartRepository);

  @override
  Future<Either<Failure, List<Cart>>> invoke(AddItemToCartParams params) {
    return cartRepository.addItemToCart(
      Cart(
        id: params.id,
        name: params.name,
        productId: params.productId,
        image: params.image,
        price: params.price,
        quantity: params.quantity,
      ),
    );
  }
}

class AddItemToCartParams {
  final String id;
  final String name;
  final String? image;
  final double? price;
  final String productId;
  final int quantity;

  AddItemToCartParams({
    required this.id,
    required this.productId,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
  });
}
