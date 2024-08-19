import 'package:e_commerce/features/cart/domain/entities/cart.dart';

Future<double> calculateTotalCart(List<Cart> cart) async {
  double total = 0;
  for (var item in cart) {
    total += item.quantity * item.price!;
  }
  return total;
}