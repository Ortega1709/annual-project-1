import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:e_commerce/features/product/domain/repositories/product_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProductsByCategoryNum implements UseCase<List<Product>, GetProductsByCategoryNumParams> {
  final ProductRepository productRepository;
  GetProductsByCategoryNum(this.productRepository);

  @override
  Future<Either<Failure, List<Product>>> invoke(GetProductsByCategoryNumParams params) {
    return productRepository.getAllProductsByCategoryNum(categoryNum: params.categoryNum);
  }

}

class GetProductsByCategoryNumParams {
  final int categoryNum;
  GetProductsByCategoryNumParams({required this.categoryNum});
}