import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_order.dart';
import 'package:e_commerce/features/cart/domain/usecases/delete_item_to_cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/cart.dart';
import '../../domain/usecases/get_cart_items.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddItemToCart _addItemToCart;
  final DeleteItemToCart _deleteItemToCart;
  final GetCartItems _getCartItems;
  final AddOrder _addOrder;
  final SharedPreferences _sharedPreferences;

  CartBloc(
      {required AddItemToCart addItemToCart,
      required DeleteItemToCart deleteItemToCart,
      required GetCartItems getCartItems,
      required AddOrder addOrder,
      required SharedPreferences sharedPreferences})
      : _getCartItems = getCartItems,
        _deleteItemToCart = deleteItemToCart,
        _addItemToCart = addItemToCart,
        _addOrder = addOrder,
        _sharedPreferences = sharedPreferences,
        super(CartInitial()) {
    on<CartEvent>((event, emit) {
      emit(CartInitial());
    });

    on<DeleteItemToCartEvent>(deleteItemsToCart);
    on<GetAllItemsEvent>(getAllItems);
    on<AddItemToCartEvent>(addItemsToCart);
    on<CartPaymentSuccessEvent>(cartPaymentSuccess);
  }

  Future<void> deleteItemsToCart(
    DeleteItemToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final response = await _deleteItemToCart.invoke(
      DeleteItemToCartParams(index: event.index),
    );
    response.fold(
      (err) => emit(CartErrorState(err.message)),
      (items) => emit(const DeleteToCartSuccessState('Suppression réussie !')),
    );
  }

  Future<void> getAllItems(
    GetAllItemsEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final response = await _getCartItems.invoke(NoParams());
    response.fold(
      (err) => emit(CartErrorState(err.message)),
      (items) => emit(CartLoadedState(items)),
    );
  }

  Future<void> addItemsToCart(
    AddItemToCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final response = await _addItemToCart.invoke(
      AddItemToCartParams(
        id: event.id,
        name: event.name,
        productId: event.productId,
        image: event.image,
        price: event.price,
        quantity: event.quantity,
      ),
    );

    response.fold(
      (err) => emit(CartErrorState(err.message)),
      (items) => emit(const AddToCartSuccessState("Ajout réussi !")),
    );
  }

  Future<void> cartPaymentSuccess(
    CartPaymentSuccessEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final userId = _sharedPreferences.getString('id');
    if (userId != null) {
      final response = await _addOrder.invoke(
        AddOrderParams(
            userId: userId,
            cart: event.carts,
            total: event.amount,
            references: event.references),
      );

      response.fold(
        (err) => emit(const CartPaymentErrorState()),
        (order) => emit(const CartPayementSuccessState()),
      );
    } else {
      emit(const CartPaymentErrorState());
    }
  }
}
