import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final String title;
  final Function()? onPressed;

  const ProductTitle({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("Voir plus"),
        )
      ],
    );
  }
}
