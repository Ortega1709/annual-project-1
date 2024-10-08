import 'dart:developer';

import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/product/data/models/product_model.dart';
import 'package:pocketbase/pocketbase.dart';

abstract interface class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getAllProductsOrderByPrice();
  Future<List<ProductModel>> getAllProductsOrderByName();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final PocketBase pocketBase;

  ProductRemoteDataSourceImpl(this.pocketBase);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      final response = await pocketBase
          .collection('descproduit')
          .getList(expand: "categorynum");

      return response.items.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllProductsOrderByName() async {
    try {
      final response = await pocketBase
          .collection('descproduit')
          .getList(expand: "categorynum",
          sort: '+name'
          );

      return response.items.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ProductModel>> getAllProductsOrderByPrice() async {
    try {
      final response = await pocketBase.collection('descproduit').getList(
            expand: "categorynum",
            sort: '+price'
          );

      return response.items.map((e) => ProductModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw ServerException(e.toString());
    }
  }
}
