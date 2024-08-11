import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimen.p16),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductItem(
          product: product,
          isLandscape: true,
          onPressed: () {
            context.push('/product-details', extra: product);
          },
        );
      },
    );
  }
}
