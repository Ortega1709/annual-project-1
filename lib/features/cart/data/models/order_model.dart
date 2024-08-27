import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:pocketbase/pocketbase.dart';

class OrderModel extends Orderl {
  OrderModel({
    required super.id,
    required super.total,
    required super.isdelivered,
    required super.created,
    required super.items,
    required super.ispaid,
  });

  factory OrderModel.fromJson(RecordModel map) {
    return OrderModel(
      id: map.id,
      total: map.data['total'],
      isdelivered: map.data['isdelivered'],
      created: DateTime.parse(map.created),
      items: map.data['items'],
      ispaid: map.data['ispaid'],
    );
  }

  Orderl toOrder() {
    return Orderl(
      id: id,
      total: total,
      isdelivered: isdelivered,
      created: created,
      items: items,
      ispaid: ispaid,
    );
  }
}
