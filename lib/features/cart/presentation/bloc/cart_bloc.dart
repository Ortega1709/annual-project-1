import 'package:e_commerce/core/utils/usecase.dart';
import 'package:e_commerce/features/cart/domain/entities/order.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_item_to_cart.dart';
import 'package:e_commerce/features/cart/domain/usecases/add_order.dart';
import 'package:e_commerce/features/cart/domain/usecases/confirm_order.dart';
import 'package:e_commerce/features/cart/domain/usecases/delete_item_to_cart.dart';
import 'package:e_commerce/features/cart/domain/usecases/get_order_by_user_id.dart';
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
  final ConfirmOrder _confirmOrder;
  final GetOrderByUserId _getOrderByUserId;

  CartBloc(
      {required AddItemToCart addItemToCart,
      required DeleteItemToCart deleteItemToCart,
      required GetCartItems getCartItems,
      required ConfirmOrder confirmOrder,
      required GetOrderByUserId getOrderByUserId,
      required AddOrder addOrder,
      required SharedPreferences sharedPreferences})
      : _getCartItems = getCartItems,
        _getOrderByUserId = getOrderByUserId,
        _deleteItemToCart = deleteItemToCart,
        _addItemToCart = addItemToCart,
        _addOrder = addOrder,
        _confirmOrder = confirmOrder,
        _sharedPreferences = sharedPreferences,
        super(CartInitial()) {
    on<CartEvent>((event, emit) {
      emit(CartInitial());
    });

    on<DeleteItemToCartEvent>(deleteItemsToCart);
    on<GetAllItemsEvent>(getAllItems);
    on<AddItemToCartEvent>(addItemsToCart);
    on<CartPaymentSuccessEvent>(cartPaymentSuccess);
    on<CartConfirmOrderEvent>(confirmOrderFun);
    on<GetOrderByUserIdEvent>(getOrderByUserIdFun);
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

  Future<void> getOrderByUserIdFun(
    GetOrderByUserIdEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(OrderLoadingState());
    final response = await _getOrderByUserId.invoke(
      GetOrderByUserIdParams(event.userId),
    );

    response.fold(
      (err) => emit(OrderErrorState(err.message)),
      (order) => emit(OrderLoadedState(order)),
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

  Future<void> confirmOrderFun(
    CartConfirmOrderEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoadingState());
    final response = await _confirmOrder.invoke(
      ConfirmOrderParams(
          commandeid: event.commandeid, reference: event.reference),
    );

    response.fold(
      (err) => emit(CartConfirmOrderErrorState(err.message)),
      (order) => emit(const CartConfirmOrderSuccessState()),
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
        (order) => emit(CartPayementSuccessState(order)),
      );
    } else {
      emit(const CartPaymentErrorState());
    }
  }
}
