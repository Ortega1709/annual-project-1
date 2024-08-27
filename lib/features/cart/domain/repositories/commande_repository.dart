import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/features/cart/domain/entities/make_order.dart';
import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CommandeRepository {
  Future<Either<Failure, String?>> makeOrder({required MakeOrder makeOrder});
  Future<Either<Failure, bool>> confirmOrder({required String commandeid, required String reference});
  Future<Either<Failure, List<Orderl>>> getAllOrderByUserId({required String userId});
}