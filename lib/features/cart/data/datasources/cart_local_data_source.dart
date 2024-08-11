import 'dart:developer';

import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/cart/data/models/cart_model.dart';
import 'package:hive/hive.dart';

abstract interface class CartLocalDataSource {
  Future<List<CartModel>> getAllItems();
  Future<void> addItemToCart(CartModel cartModel);
  Future<void> deleteItemToCart(int index);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<CartModel> cartBox;
  CartLocalDataSourceImpl(this.cartBox);

  @override
  Future<void> addItemToCart(CartModel cartModel) async {
    try {
      if (await _getItemByName(cartModel.name)) {
        throw const ServerException('Item already in cart');
      }
      await cartBox.add(cartModel);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteItemToCart(int index) async {
    try {
      await cartBox.deleteAt(index);
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