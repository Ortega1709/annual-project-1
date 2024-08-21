import 'dart:developer';

import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/cart/data/models/cart_model.dart';
import 'package:hive/hive.dart';

abstract interface class CartLocalDataSource {
  Future<List<CartModel>> getAllItems();
  Future<List<CartModel>> addItemToCart(CartModel cartModel);
  Future<List<CartModel>> deleteItemToCart(int index);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartModel> cartBox;
  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<List<CartModel>> addItemToCart(CartModel cartModel) async {
    try {
      if (await _getItemByName(cartModel.name)) {
        throw const ServerException('Item already in cart');
      }
      await cartBox.add(cartModel);
      return getAllItems();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CartModel>> deleteItemToCart(int index) async {
    try {
      await cartBox.deleteAt(index);
      return getAllItems();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<CartModel>> getAllItems() async {
    try {
      return cartBox.values.toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<dynamic> _getItemByName(String name) async {
    try {
      final items = cartBox.values.where((item) => item.name == name);
      log(items.toString());
      return items.isNotEmpty;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}