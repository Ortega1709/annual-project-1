import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel implements Cart {

  @HiveField(0)
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String? image;

  @HiveField(3)
  @override
  final double? price;

  @HiveField(4)
  @override
  final int quantity;

  @HiveField(5)
  @override
  final String productId;

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.productId,
    required this.quantity,
  });

  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      id: cart.id,
      name: cart.name,
      productId: cart.productId,
      image: cart.image,
      price: cart.price,
      quantity: cart.quantity,
    );
  }

  Cart toEntity() {
    return Cart(
      id: id,
      productId: productId,
      name: name,
      image: image,
      price: price,
      quantity: quantity,
    );
  }
}
