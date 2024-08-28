import 'package:e_commerce/features/product/domain/usecases/products_order_by_name.dart';
import 'package:e_commerce/features/product/domain/usecases/products_order_by_price.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts _getProducts;
  final ProductsOrderByName _productsOrderByName;
  final ProductsOrderByPrice _productsOrderByPrice;

  ProductBloc({
    required GetProducts getProducts,
    required ProductsOrderByName productsOrderByName,
    required ProductsOrderByPrice productsOrderByPrice,
  })  : _getProducts = getProducts,
        _productsOrderByName = productsOrderByName,
        _productsOrderByPrice = productsOrderByPrice,
        super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      emit(ProductInitial());
    });
    on<GetAllProductsEvent>(getAllProducts);
    on<GetProductsOrderByName>(getProductsOrderByNameFun);
    on<GetProductsOrderByPrice>(getProductsOrderByPriceFun);
  }

  Future<void> getAllProducts(
    GetAllProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final response = await _getProducts.invoke(NoParams());
    response.fold(
      (err) => emit(ProductErrorState(err.message)),
      (products) => emit(ProductLoadedState(products)),
    );
  }

  Future<void> getProductsOrderByNameFun(
    GetProductsOrderByName event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final response = await _productsOrderByName.invoke(NoParams());
    response.fold(
      (err) => emit(ProductErrorState(err.message)),
      (products) => emit(ProductLoadedState(products)),
    );
  }

  Future<void> getProductsOrderByPriceFun(
    GetProductsOrderByPrice event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoadingState());
    final response = await _productsOrderByPrice.invoke(NoParams());
    response.fold(
      (err) => emit(ProductErrorState(err.message)),
      (products) => emit(ProductLoadedState(products)),
    );
  }
}
