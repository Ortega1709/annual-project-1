import 'package:e_commerce/features/cart/domain/entities/make_order.dart';

class MakeOrderModel extends MakeOrder {
  MakeOrderModel({
    super.id,
    required super.references,
    required super.userId,
    required super.total,
    required super.cart,
  });

  Map<String, dynamic> toJson() {
    return {
      "userid": userId,
      "total": total,
      "isdelivered": false,
      "ispaid": false,
      "items": cart.length
    };
  }
}
