import 'package:e_commerce/core/errors/exception.dart';
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/cart/data/datasources/commande_remote_data_source.dart';
import 'package:e_commerce/features/cart/data/models/make_order_model.dart';
import 'package:e_commerce/features/cart/domain/entities/make_order.dart';
import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:e_commerce/features/cart/domain/entities/order_detail.dart';
import 'package:e_commerce/features/cart/domain/repositories/commande_repository.dart';
import 'package:fpdart/fpdart.dart';

class CommandeRepositoryImpl implements CommandeRepository {
  final CommandeRemoteDataSource commandeRemoteDataSource;
  CommandeRepositoryImpl(this.commandeRemoteDataSource);

  @override
  Future<Either<Failure, String?>> makeOrder(
      {required MakeOrder makeOrder}) async {
    try {
      final makeOrderModel = MakeOrderModel(
          references: makeOrder.references,
          userId: makeOrder.userId,
          total: makeOrder.total,
          cart: makeOrder.cart);

      return right(await commandeRemoteDataSource.makeOrders(
          makeOrderModel: makeOrderModel));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> confirmOrder(
      {required String commandeid, required String reference}) async {
    try {
      return right(await commandeRemoteDataSource.confirmOrder(
          commandeid: commandeid, reference: reference));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Orderl>>> getAllOrderByUserId(
      {required String userId}) async {
    try {
      final ordersModel = await commandeRemoteDataSource.getAllOrderByUserId(
        userId: userId,
      );
      final orders = ordersModel.map((e) => e.toOrder()).toList();
      return right(orders);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<OrderDetail>>> getAllDetailsOrderByOrderId({required String orderId}) async {
    try {
      final orderDetailsModel = await commandeRemoteDataSource.getAllDetailsOrderByOrderId(orderId: orderId);
      final orderDetails = orderDetailsModel.map((e) => e.toOrderDetail()).toList();

      return right(orderDetails);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
