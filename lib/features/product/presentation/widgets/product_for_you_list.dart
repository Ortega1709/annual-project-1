import 'package:e_commerce/features/product/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class ProductForYouList extends StatelessWidget {
  const ProductForYouList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResponsiveGridList(
          shrinkWrap: true,
          horizontalGridMargin: 50,
          verticalGridMargin: 50,
          minItemsPerRow: 1,
          maxItemsPerRow: 6,
          minItemWidth: 10,
          children: List.generate(
            20,
            (index) => ProductItem(
              title: "Produit $index",
              description: "Description $index",
              price: "Price $index",
              onPressed: () {
                context.push('/products/$index');
              },
            ),
          ),
        ),
      ],
    );
  }
}
