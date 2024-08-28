
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/entities/order_detail.dart';
import 'package:e_commerce/features/cart/domain/repositories/commande_repository.dart';
import 'package:fpdart/fpdart.dart';

class OrderDetailByOrderId implements UseCase<List<OrderDetail>, OrderDetailByOrderIdParams> {
  final CommandeRepository commandeRepository;
  OrderDetailByOrderId(this.commandeRepository);

  @override
  Future<Either<Failure, List<OrderDetail>>> invoke(OrderDetailByOrderIdParams params) async {
    return commandeRepository.getAllDetailsOrderByOrderId(orderId: params.orderId);
  }
}


class OrderDetailByOrderIdParams {
  final String orderId;
  OrderDetailByOrderIdParams(this.orderId);
}