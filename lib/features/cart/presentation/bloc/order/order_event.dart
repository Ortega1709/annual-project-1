part of 'order_bloc.dart';

sealed class OrderEvent extends Equatable {
  const OrderEvent();
}

final class GetDetailOrderByOrderIdEvent extends OrderEvent {
  final String orderId;
  const GetDetailOrderByOrderIdEvent({required this.orderId});

  @override
  List<Object?> get props => [orderId];
}