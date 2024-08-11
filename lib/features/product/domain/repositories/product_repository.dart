import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<Product>>> getAllProducts();

  Future<Either<Failure, List<Product>>> getAllProductsByCategoryNum({
    required int categoryNum,
  });
}
