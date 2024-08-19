import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future authRequiredDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColor.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimen.p12),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Oups',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: Text(
          'Authentifiez-vous afin de bénéficier de cette fonctionnalité.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/sign-in');
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimen.p12),
              ),
            ),
            child: Text(
              "S'authentifier",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500, color: AppColor.whiteColor),
            ),
          ),
        ],
      );
    },
  );
}
