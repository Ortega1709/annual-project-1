part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();
}

final class GetAllItemsEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

final class AddItemToCartEvent extends CartEvent {
  final String id;
  final String name;
  final String? image;
  final double? price;
  final String productId;
  final int quantity;

  const AddItemToCartEvent({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
    required this.productId,
  });

  @override
  List<Object?> get props => [id, name, image, price, quantity];
}

final class DeleteItemToCartEvent extends CartEvent {
  final int index;
  const DeleteItemToCartEvent(this.index);

  @override
  List<Object?> get props => [index];
}

final class CartPaymentSuccessEvent extends CartEvent {
  final double amount;
  final String references;
  final List<Cart> carts;

  const CartPaymentSuccessEvent({
    required this.amount,
    required this.references,
    required this.carts,
  });

  @override
  List<Object?> get props => [amount, carts];
}

final class CartConfirmOrderEvent extends CartEvent {
  final String commandeid;
  final String reference;

  const CartConfirmOrderEvent({required this.commandeid, required this.reference});

  @override
  List<Object?> get props => [commandeid, reference];
}

final class GetOrderByUserIdEvent extends CartEvent {
  final String userId;
  const GetOrderByUserIdEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
