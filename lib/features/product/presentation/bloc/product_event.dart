part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetAllProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

final class GetProductsOrderByName extends ProductEvent {
  @override
  List<Object?> get props => [];
}

final class GetProductsOrderByPrice extends ProductEvent {
  @override
  List<Object?> get props => [];
}
