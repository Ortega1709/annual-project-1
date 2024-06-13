import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MIconButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function()? onPressed;

  const MIconButton(
      {super.key,
      required this.icon,
      required this.text,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, size) {
        return size.isMobile
            ? IconButton(onPressed: onPressed, icon: Icon(icon))
            : InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(AppDimen.p16),
                radius: 5.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon),
                    const SizedBox(width: AppDimen.p8),
                    Text(
                      text,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
      },
    );
  }
}
