import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/shared/widgets/progress.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/calculate_total_cart.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/features/cart/presentation/widgets/cart_list.dart';
import 'package:e_commerce/features/cart/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  String? commandeid;
  double? confirmAmount;

  @override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(GetAllItemsEvent());
  }

  @override
  Widget build(BuildContext context) {
    confirmOrder({required BuildContext context, required String commandeid, required double amount}) async {
      final response = await StripeService.instance.makePayment(
        context,
        amount,
      );

      if (response != '') {
        context.read<CartBloc>().add(
          CartConfirmOrderEvent(commandeid: commandeid, reference: response)
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon panier"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is DeleteToCartSuccessState) {
            Messages.success("Panier", state.message, context);
            context.read<CartBloc>().add(GetAllItemsEvent());
          }

          if (state is CartPayementSuccessState) {
            // Messages.success("Paiement", 'Paiement réussi !', context);
            context.read<CartBloc>().add(GetAllItemsEvent());
          }

          if (state is CartConfirmOrderSuccessState) {
            Messages.success("Paiement", 'Paiement réussi', context);
            context.read<CartBloc>().add(GetAllItemsEvent());
          }
        },
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const Center(child: Progress());
          } else if (state is CartLoadedState) {
            return CartList(
              cart: state.cart,
              onDismissed: (index) {
                context.read<CartBloc>().add(DeleteItemToCartEvent(index));
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartPayementSuccessState) {
            setState(() {
              commandeid = state.commandeid;
            });

            confirmOrder(context: context, commandeid: commandeid!, amount: confirmAmount!);
          }
        },
        builder: (context, state) {
          if (state is CartLoadedState) {
            return state.cart.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: AppDimen.p16),
                    child: MButton(
                      onPressed: () async {
                        final amount = await calculateTotalCart(state.cart);
                        // ignore: use_build_context_synchronously
                        context.read<CartBloc>().add(
                              CartPaymentSuccessEvent(
                                carts: state.cart,
                                amount: amount,
                                references: '',
                              ),
                            );

                        setState(() {
                          confirmAmount = amount;
                        });
                      },
                      text: 'Commander',
                    ),
                  )
                : const SizedBox.shrink();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
