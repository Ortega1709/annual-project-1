import 'package:e_commerce/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_dimen.dart';

class ProductPromo extends StatelessWidget {
  const ProductPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimen.p16,
      ),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.cyanColor,
            borderRadius: BorderRadius.circular(AppDimen.p12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimen.p16,
            horizontal: AppDimen.p16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Votre épicerie en ligne pour une expérience gourmande",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: AppDimen.p16),
                      InkWell(
                        onTap: () {
                          context.push("/discovery");
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Découvrir",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 16.0 / 9.0,
                  child: SvgPicture.asset(
                    'assets/svg/vegetable-2.svg',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
