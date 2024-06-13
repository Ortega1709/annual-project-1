import 'package:e_commerce/core/shared/widgets/m_icon_button.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_category.dart';
import 'package:e_commerce/features/product/presentation/widgets/product_promo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductDiscovery extends StatefulWidget {
  const ProductDiscovery({super.key});

  @override
  State<ProductDiscovery> createState() => _ProductDiscoveryState();
}

class _ProductDiscoveryState extends State<ProductDiscovery> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            MIconButton(
              icon: CupertinoIcons.person,
              text: "Compte",
              onPressed: () {},
            ),
            SizedBox(width: size.isMobile ? AppDimen.p16 : AppDimen.p32),
            MIconButton(
              icon: CupertinoIcons.shopping_cart,
              text: "Panier",
              onPressed: () {},
            ),
            SizedBox(width: size.isMobile ? AppDimen.p16 : AppDimen.p32)
          ],
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.isMobile ? AppDimen.p16 : AppDimen.p32),
                const ProductPromo(),
                SizedBox(height: size.isMobile ? AppDimen.p16 : AppDimen.p32),
                const ProductCategory(categories: [])
              ],
            ),
          ),
        ),
      );
    });
  }
}
