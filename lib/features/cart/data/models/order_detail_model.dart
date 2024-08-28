import 'package:e_commerce/features/cart/domain/entities/order_detail.dart';
import 'package:pocketbase/pocketbase.dart';

class OrderDetailModel extends OrderDetail {
  OrderDetailModel({
    required super.id,
    required super.quantity,
    required super.productname,
    required super.productprice,
    required super.url,
    required super.subtotal,
  });

  factory OrderDetailModel.fromJson(RecordModel map) {
    return OrderDetailModel(
      id: map.id,
      quantity: map.data['quantity'] as int,
      subtotal: map.data['subtotal'] as double,
      productname: map.expand['produitid']!.first.data['name'],
      productprice: map.expand['produitid']!.first.data['price'],
      url: map.expand['produitid']!.first.data['image'],
    );
  }

  OrderDetail toOrderDetail() {
    return OrderDetail(
      id: id,
      quantity: quantity,
      productname: productname,
      productprice: productprice,
      url: url,
      subtotal: subtotal,
    );
  }
}
