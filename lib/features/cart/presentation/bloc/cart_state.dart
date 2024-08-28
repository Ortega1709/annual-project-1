part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
}

final class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

final class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

final class CartLoadedState extends CartState {
  final List<Cart> cart;
  const CartLoadedState(this.cart);

  @override
  List<Object?> get props => [cart];

}

final class OrderLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

final class OrderLoadedState extends CartState {
  final List<Orderl> orders;
  const OrderLoadedState(this.orders);

  @override
  List<Object?> get props => [orders];
}


final class OrderErrorState extends CartState {
  final String errorMessage;
  const OrderErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

final class CartErrorState extends CartState {
  final String message;
  const CartErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

final class CartPaymentErrorState extends CartState {
  const CartPaymentErrorState();

  @override
  List<Object?> get props => [];
}

final class AddToCartSuccessState extends CartState {
  final String message;
  const AddToCartSuccessState(this.message);

  @override
  List<Object?> get props => [message];

}

final class DeleteToCartSuccessState extends CartState {
  final String message;
  const DeleteToCartSuccessState(this.message);

  @override
  List<Object?> get props => [message];

}

final class CartPayementSuccessState extends CartState {
  final String? commandeid;
  const CartPayementSuccessState(this.commandeid);

  @override
  List<Object?> get props => [];
}

final class CartConfirmOrderSuccessState extends CartState {
  const CartConfirmOrderSuccessState();

  @override
  List<Object?> get props => [];
}

final class CartConfirmOrderErrorState extends CartState {
  final String message;
  const CartConfirmOrderErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
