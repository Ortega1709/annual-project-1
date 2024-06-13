import 'package:e_commerce/core/shared/widgets/m_category_chip.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductCategory extends StatefulWidget {
  final List<String> categories;

  const ProductCategory({super.key, required this.categories});

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
    return ResponsiveBuilder(builder: (context, size) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: size.isMobile ? AppDimen.p16 : AppDimen.p32),
            MCategoryChip(
              selected: selected == 0,
              category: "Toutes",
              onPressed: () {
                setState(() {
                  selected = 0;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 1,
              category: "Légumes-feuilles",
              onPressed: () {
                setState(
                  () {
                    selected = 1;
                  },
                );
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 2,
              category: "Légumes racines",
              onPressed: () {
                setState(() {
                  selected = 2;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 3,
              category: "Légumes Fleurs",
              onPressed: () {
                setState(() {
                  selected = 3;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 4,
              category: "Légumes Fruits",
              onPressed: () {
                setState(() {
                  selected = 4;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 5,
              category: "Petits Fruits",
              onPressed: () {
                setState(() {
                  selected = 5;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 6,
              category: "Céréales",
              onPressed: () {
                setState(() {
                  selected = 6;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 7,
              category: "Fruits",
              onPressed: () {
                setState(() {
                  selected = 7;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 8,
              category: "La viande rouge",
              onPressed: () {
                setState(() {
                  selected = 8;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 9,
              category: "La viande blanche",
              onPressed: () {
                setState(() {
                  selected = 9;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 10,
              category: "La viande noire ou le gibier",
              onPressed: () {
                setState(() {
                  selected = 10;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 11,
              category: "Poissons",
              onPressed: () {
                setState(() {
                  selected = 11;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 12,
              category: "Crustacés",
              onPressed: () {
                setState(() {
                  selected = 12;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 13,
              category: "Pains et Brioches",
              onPressed: () {
                setState(() {
                  selected = 13;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 14,
              category: "Pâtisserie",
              onPressed: () {
                setState(() {
                  selected = 14;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 15,
              category: "Boissons",
              onPressed: () {
                setState(() {
                  selected = 15;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 16,
              category: "Boites de conserve",
              onPressed: () {
                setState(() {
                  selected = 16;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 17,
              category: "Produits d'hygiène",
              onPressed: () {
                setState(() {
                  selected = 17;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              selected: selected == 18,
              category: "Produits de puériculture",
              onPressed: () {
                setState(() {
                  selected = 18;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p8 : AppDimen.p16),
            MCategoryChip(
              category: "Tabac",
              selected: selected == 19,
              onPressed: () {
                setState(() {
                  selected = 19;
                });
              },
            ),
            SizedBox(width: size.isMobile ? AppDimen.p16 : AppDimen.p32),
          ],
        ),
      );
    });
  }
}
