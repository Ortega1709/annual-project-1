import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class MButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const MButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimen.p16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimen.p32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.p12),
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColor.whiteColor)),
        ),
      ),
    );
  }
}
