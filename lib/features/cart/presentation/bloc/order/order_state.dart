part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
}

final class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

final class OrderDetailLoadingState extends OrderState {
  @override
  List<Object?> get props => [];
}

final class OrderDetailLoadedState extends OrderState {
  final List<OrderDetail> orderDetails;
  const OrderDetailLoadedState(this.orderDetails);

  @override
  List<Object?> get props => [orderDetails];
}

final class OrderDetailErrorState extends OrderState {
  final String errorMessage;
  const OrderDetailErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

