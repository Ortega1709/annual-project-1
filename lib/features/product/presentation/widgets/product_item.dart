import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final Function()? onPressed;

  const ProductItem({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      hoverColor: AppColor.transparentColor,
      highlightColor: AppColor.transparentColor,
      splashColor: AppColor.transparentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: title,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  color: AppColor.grayColor,
                  borderRadius: BorderRadius.circular(AppDimen.p12)),
            ),
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(description, overflow: TextOverflow.ellipsis, maxLines: 1),
            trailing: Text(price),
          ),
          MButton(text: "Ajouter", onPressed: () {})
        ],
      ),
    );
  }
}
