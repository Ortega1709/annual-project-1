import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:e_commerce/features/cart/presentation/widgets/cart_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/theme/app_dimen.dart';

class CartList extends StatelessWidget {
  final List<Cart> cart;
  final Function(int) onDismissed;

  const CartList({super.key, required this.cart, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return cart.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: SvgPicture.asset(
                    'assets/svg/empty-cart.svg',
                    width: 150,
                    height: 150,
                  ),
                ),
                Text(
                  'Oops !',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: AppDimen.p8),
                Text(
                  textAlign: TextAlign.center,
                  'Aucun produit dans votre panier.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimen.p16),
              child: Container(
                height: .5,
                color: AppColor.greyColor.withOpacity(.5),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: AppDimen.p16),
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
