import 'package:e_commerce/features/cart/domain/entities/order_detail.dart';
import 'package:e_commerce/features/cart/domain/usecases/order_detail_by_order_id.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';

part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderDetailByOrderId _orderDetailByOrderId;

  OrderBloc({required OrderDetailByOrderId orderDetailByOrderId})
      : _orderDetailByOrderId = orderDetailByOrderId,
        super(OrderInitial()) {
    on<OrderEvent>((event, emit) {
      emit(OrderInitial());
    });
    on<GetDetailOrderByOrderIdEvent>(getDetailsOrderByOrderIdFun);
  }
  Future<void> getDetailsOrderByOrderIdFun(
    GetDetailOrderByOrderIdEvent event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderDetailLoadingState());

    final response = await _orderDetailByOrderId.invoke(
      OrderDetailByOrderIdParams(event.orderId),
    );

    response.fold(
      (err) => emit(OrderDetailErrorState(err.message)),
      (res) => emit(OrderDetailLoadedState(res)),
    );
  }
}
