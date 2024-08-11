import 'package:e_commerce/core/shared/widgets/m_category_chip.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductCategory extends StatefulWidget {
  final List<String> categories;

  const ProductCategory({
    super.key,
    required this.categories,
  });

  @override
  State<ProductCategory> createState() => _ProductCategoryState();
}

class _ProductCategoryState extends State<ProductCategory> {
  late int selected = 0;

  @override
  void initState() {
    selected = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        return MCategoryChip(
          category: widget.categories[index],
          selected: selected == index,
          onPressed: () {
            setState(() {
              selected = index;
            });
          },
        );
      },
    );
  }
}
