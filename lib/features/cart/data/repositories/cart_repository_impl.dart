import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:e_commerce/features/cart/data/models/cart_model.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:e_commerce/features/cart/domain/repositories/cart_repository.dart';
import 'package:fpdart/fpdart.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource cartLocalDataSource;

  CartRepositoryImpl(this.cartLocalDataSource);

  @override
  Future<Either<Failure, void>> addItemToCart(Cart cart) async {
    try {
      return right(
          await cartLocalDataSource.addItemToCart(CartModel.fromEntity(cart)));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteItemToCart(int index) async {
    try {
      return right(await cartLocalDataSource.deleteItemToCart(index));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Cart>>> getAllItems() async {
    try {
      return right(await cartLocalDataSource.getAllItems());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
