import 'package:e_commerce/features/cart/domain/entities/cart.dart';

class MakeOrder {
  final String? id;
  final String references;
  final String userId;
  final double total;
  final List<Cart> cart;

  MakeOrder({
    this.id,
    required this.references,
    required this.userId,
    required this.total,
    required this.cart,
  });
}