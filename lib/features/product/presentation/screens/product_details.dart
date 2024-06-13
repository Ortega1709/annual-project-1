import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_dimen.dart';

class ProductDetails extends StatefulWidget {
  final String productId;
  const ProductDetails({super.key, required this.productId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kIsWeb ? null: null,
        automaticallyImplyLeading: false,
      ),
      body:  Column(
        children: [
          Hero(tag: widget.productId, child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
                color: AppColor.grayColor,
                borderRadius: BorderRadius.circular(AppDimen.p12)),
          ),)
        ],
      ),
    );
  }
}
