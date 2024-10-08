import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../../theme/app_dimen.dart';

class MOutlinedButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const MOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimen.p16,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.transparentColor,
          shadowColor: AppColor.transparentColor,
          surfaceTintColor: AppColor.transparentColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColor.greyColor),
            borderRadius: BorderRadius.circular(AppDimen.p32),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppDimen.p12),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
