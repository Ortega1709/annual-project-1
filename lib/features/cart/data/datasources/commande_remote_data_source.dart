
import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/features/cart/data/models/make_order_model.dart';
import 'package:e_commerce/features/cart/data/models/order_model.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:pocketbase/pocketbase.dart';

abstract class CommandeRemoteDataSource {
  Future<String?> makeOrders({required MakeOrderModel makeOrderModel});
  Future<bool> confirmOrder({
    required String commandeid,
    required String reference,
  });
  Future<List<OrderModel>> getAllOrderByUserId({required String userId});
}

class CommandeRemoteDataSourceImpl implements CommandeRemoteDataSource {
  final PocketBase pocketBase;
  CommandeRemoteDataSourceImpl(this.pocketBase);

  @override
  Future<String?> makeOrders({required MakeOrderModel makeOrderModel}) async {
    try {
      // check if products in cart as more products available
      final isOrderable = await _productsAsQteAvailable(
        productCarts: makeOrderModel.cart,
      );

      if (!isOrderable) {
        throw Exception('Not enough products available');
      }

      // Update the quantities of products in the 'descproduit' collection
      final updateProductsQte =
          await _updateProductsQteAvailable(productCarts: makeOrderModel.cart);

      if (updateProductsQte) {
        // Create a new commande record in the 'commande' collection with the provided data.
        final makeOrderRecord = await pocketBase
            .collection('commande')
            .create(body: makeOrderModel.toJson());

        // Create a new transaction record in the 'transactions' collection with the commande id and reference.
        /* await pocketBase.collection('transactions').create(body: {
          "commandeid": makeOrderRecord.id,
          "reference": makeOrderModel.references,
        }); */

        // Create a new relation record in the 'detailscommande' collection with the product id, quantity
        for (Cart cart in makeOrderModel.cart) {
          await pocketBase.collection('detailscommande').create(body: {
            "commandeid": makeOrderRecord.id,
            "produitid": cart.id,
            "quantity": cart.quantity,
            "subtotal": cart.quantity * cart.price!
          });
        }

        return makeOrderRecord.id;
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> confirmOrder({required String commandeid, required String reference}) async {
    try {
      // Update the 'commande' record with the provided reference
      await pocketBase
          .collection('commande')
          .update(commandeid, body: {"ispaid": true});

      // Create a new transaction record in the 'transactions' collection with the commande id and reference.
      await pocketBase.collection('transactions').create(body: {
        "commandeid": commandeid,
        "reference": reference,
      });

      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  Future<bool> _productsAsQteAvailable(
      {required List<Cart> productCarts}) async {
    // Check if products in cart have enough stock
    for (Cart cart in productCarts) {
      final product =
          await pocketBase.collection('descproduit').getOne(cart.id);
      if (product.data['seuilrupture'] < cart.quantity) {
        return false;
      }
    }
    return true;
  }

  Future<bool> _updateProductsQteAvailable(
      {required List<Cart> productCarts}) async {
    // Update products stock in the 'descproduit' collection
    for (Cart cart in productCarts) {
      final product =
          await pocketBase.collection('descproduit').getOne(cart.id);
      final newQuantity = product.data['seuilrupture'] - cart.quantity;
      await pocketBase
          .collection('descproduit')
          .update(product.id, body: {"seuilrupture": newQuantity});
    }
    return true;
  }
  
  @override
  Future<List<OrderModel>> getAllOrderByUserId({required String userId}) async {
    try {
      final orders = await pocketBase.collection('commande').getList(
        filter: 'userid="$userId"'
      );
      return orders.items.map((e) => OrderModel.fromJson(e)).toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
