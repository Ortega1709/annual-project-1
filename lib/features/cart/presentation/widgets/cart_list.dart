import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:e_commerce/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimen.dart';

class CartList extends StatelessWidget {
  final List<Cart> cart;
  final Function(int) onDismissed;

  const CartList({super.key, required this.cart, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimen.p16),
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final cartItem = cart[index];
        return Dismissible(
          background: Container(
            color: AppColor.redColor,
            child: const Icon(CupertinoIcons.trash, color: Colors.white),
          ),
          onDismissed: (DismissDirection direction) {
            onDismissed(index);
          },
          key: ValueKey<Cart>(cartItem),
          child: CartItem(
            cart: cartItem,
            isLandscape: true,
            onPressed: () {},
          ),
        );
      },
    );
  }
}
