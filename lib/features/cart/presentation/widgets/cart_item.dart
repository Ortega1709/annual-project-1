import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/secrets.dart';
import 'package:e_commerce/features/cart/domain/entities/cart.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/progress.dart';

class CartItem extends StatelessWidget {
  final Cart cart;
  final bool isLandscape;
  final Function()? onPressed;

  const CartItem({
    super.key,
    required this.cart,
    required this.onPressed,
    this.isLandscape = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: AppColor.transparentColor,
      highlightColor: AppColor.transparentColor,
      splashColor: AppColor.transparentColor,
      child: isLandscape
          ? ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(AppDimen.p8),
                child: CachedNetworkImage(
                  imageUrl:
                      "${Secrets.pocketbaseFileUrl}/${cart.id}/${cart.image}",
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  placeholder: (context, url) {
                    return const Progress();
                  },
                  errorWidget: (context, url, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
              title: Text(
                cart.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                "€ ${cart.price}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColor.greyColor),
              ),
              trailing: Text(cart.quantity.toString()))
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: cart.id,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        color: AppColor.grayColor,
                        borderRadius: BorderRadius.circular(AppDimen.p12)),
                  ),
                ),
                ListTile(
                  title: Text(cart.name,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: const Text("",
                      overflow: TextOverflow.ellipsis, maxLines: 2),
                  trailing: Text(cart.price.toString()),
                ),
              ],
            ),
    );
  }
}
