import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/core/utils/secrets.dart';
import 'package:e_commerce/features/product/domain/entities/product.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared/widgets/progress.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isLandscape;
  final Function()? onPressed;

  const ProductItem({
    super.key,
    required this.product,
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
              leading: Hero(
                tag: product.name,
                transitionOnUserGestures: true,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimen.p8),
                  child: CachedNetworkImage(
                    imageUrl:
                        "${Secrets.pocketbaseFileUrl}/${product.id}/${product.image}",
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
              ),
              title: Text(product.name,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Text(
                product.description.toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: AppColor.greyColor),
              ),
              trailing: Text(
                "€ ${product.price}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.blackColor,
                    ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: product.id,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                        color: AppColor.grayColor,
                        borderRadius: BorderRadius.circular(AppDimen.p12)),
                  ),
                ),
                ListTile(
                  title: Text(product.name,
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(product.description.toString(),
                      overflow: TextOverflow.ellipsis, maxLines: 2),
                  trailing: Text(product.price.toString()),
                ),
                // MButton(text: "Ajouter", onPressed: () {})
              ],
            ),
    );
  }
}
