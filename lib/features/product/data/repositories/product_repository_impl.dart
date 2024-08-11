import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/product/data/datasources/product_remote_data_source.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource productRemoteDataSource;
  ProductRepositoryImpl(this.productRemoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> getAllProducts() async {
    try {
      final products = await productRemoteDataSource.getAllProducts();
      return right(products);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> getAllProductsByCategoryNum({
    required int categoryNum,
  }) async {
    try {
      final products = await productRemoteDataSource
          .getAllProductsByCategoryNum(categoryNum: categoryNum);
      return right(products);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
