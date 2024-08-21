import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/cart/data/models/make_order_model.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

abstract class CommandeRemoteDataSource {
  Future<bool> makeOrders({required MakeOrderModel makeOrderModel});
}

class CommandeRemoteDataSourceImpl implements CommandeRemoteDataSource {
  final PocketBase pocketBase;
  CommandeRemoteDataSourceImpl(this.pocketBase);

  @override
  Future<bool> makeOrders({required MakeOrderModel makeOrderModel}) async {
    try {
      // Create a new commande record in the 'commande' collection with the provided data.
      final makeOrderRecord = await pocketBase
          .collection('commande')
          .create(body: makeOrderModel.toJson());

      // Create a new transaction record in the 'transactions' collection with the commande id and reference.
      await pocketBase.collection('transactions').create(body: {
        "commandeid": makeOrderRecord.id,
        "reference": makeOrderModel.references,
      });

      // Create a new relation record in the 'detailscommande' collection with the product id, quantity
      for (Cart cart in makeOrderModel.cart) {
        await pocketBase.collection('detailscommande').create(body: {
          "commandeid": makeOrderRecord.id,
          "produitid": cart.id,
          "quantity": cart.quantity,
          "subtotal": cart.quantity * cart.price!
        });

        debugPrint('id: ${makeOrderRecord.id}');
      }
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
