part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
}

final class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

final class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

final class ProductLoadedState extends ProductState {
  final List<Product> products;
  const ProductLoadedState(this.products);

  @override
  List<Object?> get props => [products];
}

final class ProductErrorState extends ProductState {
  final String message;
  const ProductErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
