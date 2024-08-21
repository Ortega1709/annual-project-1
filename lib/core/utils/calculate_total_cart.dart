import 'dart:isolate';

import 'package:e_commerce/features/cart/domain/entities/cart.dart';

// run calculate total cart in a separate isolate
// to avoid blocking the main thread
Future<double> calculateTotalCart(List<Cart> cart) async {
  double total = await Isolate.run(() async {
    double total = 0;
    for (var item in cart) {
      total += item.quantity * item.price!;
    }
    return total;
  });

  return total;
}
