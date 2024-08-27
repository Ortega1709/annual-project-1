
import 'package:e_commerce/core/errors/failure.dart';
import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/repositories/commande_repository.dart';
import 'package:fpdart/fpdart.dart';

class ConfirmOrder implements UseCase<bool, ConfirmOrderParams>{
  final CommandeRepository commandeRepository;
  ConfirmOrder(this.commandeRepository);

  @override
  Future<Either<Failure, bool>> invoke(ConfirmOrderParams params) {
    return commandeRepository.confirmOrder(commandeid: params.commandeid, reference: params.reference);
  }
  
}


class ConfirmOrderParams {
  final String commandeid;
  final String reference;

  const ConfirmOrderParams({required this.commandeid, required this.reference});
}