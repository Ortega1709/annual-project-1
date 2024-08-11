import 'dart:async';
import 'dart:developer';

import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:e_commerce/features/cart/domain/usecases/delete_item_to_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/cart.dart';
import '../../domain/usecases/get_cart_items.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddItemToCart _addItemToCart;
  final DeleteItemToCart _deleteItemToCart;
  final GetCartItems _getCartItems;

  CartBloc({
    required AddItemToCart addItemToCart,
    required DeleteItemToCart deleteItemToCart,
    required GetCartItems getCartItems,
  })  : _getCartItems = getCartItems,
        _deleteItemToCart = deleteItemToCart,
        _addItemToCart = addItemToCart,
        super(CartInitial()) {

    on<GetAllItemsEvent>((event, emit) async {
      final response = await _getCartItems.invoke(NoParams());
      response.fold(
        (err) => emit(CartError(err.message)),
        (items) => emit(CartLoaded(items)),
      );
    });

    on<AddItemToCartEvent>((event, emit) async {
      final response = await _addItemToCart.invoke(
        AddItemToCartParams(
          id: event.id,
          name: event.name,
          image: event.image,
          price: event.price,
          quantity: event.quantity,
        ),
      );

      response.fold(
        (err) => emit(CartError(err.message)),
        (items) => emit(const AddToCartSuccess("Add to cart")),
      );
    });

    on<DeleteItemToCartEvent>((event, emit) async {
      final response = await _deleteItemToCart.invoke(
        DeleteItemToCartParams(index: event.index),
      );

      response.fold((err) => emit(CartError(err.message)), (items) {});
    });
  }
}