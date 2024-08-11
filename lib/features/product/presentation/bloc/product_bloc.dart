import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/usecase.dart';
import '../../domain/entities/product.dart';
import '../../domain/usecases/get_products.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts _getProducts;

  ProductBloc({required GetProducts getProducts}): _getProducts = getProducts, super(ProductInitial()) {

    on<ProductEvent>((event, emit) {
      log("Product event");
    });

    on<GetAllProductsEvent>((event, emit) async {
      final response = await _getProducts.invoke(NoParams());
      response.fold(
        (err) => emit(ProductError(err.message)),
        (products) => emit(ProductLoaded(products)),
      );
    });
  }
}