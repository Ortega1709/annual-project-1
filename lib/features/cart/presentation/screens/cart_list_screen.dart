import 'dart:io';

import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/messages.dart';
import 'package:e_commerce/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce/features/cart/presentation/widgets/cart_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  void initState() {
    super.initState();
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }


  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(GetAllItemsEvent());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon panier"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is DeleteToCartSuccess) {
            Messages.success("Deleted", state.message, context);
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const CircularProgressIndicator();
          } else if (state is CartLoaded) {
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppDimen.p16),
        child: MButton(
          onPressed: () {}, text: '',
        )
      ),
    );
  }
}
