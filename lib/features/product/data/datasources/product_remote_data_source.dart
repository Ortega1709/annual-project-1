import 'dart:developer';

import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:pocketbase/pocketbase.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getAllProductsOrderBy({required String name});
  Future<List<ProductModel>> getAllProductsByCategoryNum({
    required int categoryNum,
  });
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final PocketBase pocketBase;

  ProductRemoteDataSourceImpl(this.pocketBase);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await pocketBase
          .collection('histovaleur')
          .getList(page: 1, perPage: 20, expand: "produitid.categorynum");

      return response.items.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllProductsByCategoryNum(
      {required int categoryNum}) {
    throw UnimplementedError();
  }

  @override
  Future<List<ProductModel>> getAllProductsOrderBy({required String name}) {
  
    throw UnimplementedError();
  }
}
