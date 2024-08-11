
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CartRepository {
  Future<Either<Failure, List<Cart>>> getAllItems();
  Future<Either<Failure, void>> addItemToCart(Cart cart);
  Future<Either<Failure, void>> deleteItemToCart(int index);
}