part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetAllProductsEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}