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
  final int quantity;

  const AddItemToCartEvent(
    this.id,
    this.name,
    this.image,
    this.price,
    this.quantity,
  );

  @override
  List<Object?> get props => [id, name, image, price, quantity];
}

final class DeleteItemToCartEvent extends CartEvent {
  final int index;
  const DeleteItemToCartEvent(this.index);

  @override
  List<Object?> get props => [index];
}
