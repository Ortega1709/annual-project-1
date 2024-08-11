part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

final class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartLoaded extends CartState {
  final List<Cart> cart;
  const CartLoaded(this.cart);

  @override
  List<Object?> get props => [cart];

}

final class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

final class AddToCartSuccess extends CartState {
  final String message;
  const AddToCartSuccess(this.message);

  @override
  List<Object?> get props => [message];

}

final class DeleteToCartSuccess extends CartState {
  final String message;
  const DeleteToCartSuccess(this.message);

  @override
  List<Object?> get props => [message];

}

