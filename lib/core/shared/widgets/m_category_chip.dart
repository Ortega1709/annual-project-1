import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class MCategoryChip extends StatelessWidget {
  final String category;
  final bool selected;
  final Function()? onPressed;

  const MCategoryChip(
      {super.key,
      required this.category,
      required this.selected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppDimen.p8),
      child: Container(
        decoration: BoxDecoration(
            color: selected ? AppColor.primaryColor : AppColor.grayColor,
            borderRadius: BorderRadius.circular(AppDimen.p8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimen.p12, vertical: AppDimen.p4),
          child: Text(
            category,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color:
              selected ? AppColor.whiteColor : AppColor.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
