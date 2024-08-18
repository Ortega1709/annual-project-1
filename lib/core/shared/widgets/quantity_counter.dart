import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';

class QuantityCounter extends StatelessWidget {
  final Function() onAdd;
  final Function() onRemove;
  final int quantity;

  const QuantityCounter({
    super.key,
    required this.quantity,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.grayColor,
        borderRadius: BorderRadius.circular(AppDimen.p24)
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimen.p4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              customBorder: const CircleBorder(),
              onTap: onRemove,
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(AppDimen.p4),
                  child: Icon(
                    Icons.remove,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimen.p16),
            Text(quantity.toString(), style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(width: AppDimen.p16),
            InkWell(
              customBorder: const CircleBorder(),
              onTap: onAdd,
              child: Container(
                decoration: const BoxDecoration(
                    color: AppColor.primaryColor,
                    shape: BoxShape.circle),
                child: const Padding(
                  padding: EdgeInsets.all(AppDimen.p4),
                  child: Icon(
                    Icons.add,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
