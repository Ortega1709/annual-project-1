import 'package:e_commerce/core/shared/widgets/m_button.dart';
import 'package:e_commerce/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../../core/theme/app_dimen.dart';

class ProductPromo extends StatelessWidget {
  const ProductPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, size) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.isMobile ? AppDimen.p16 : AppDimen.p32),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.cyanColor,
            borderRadius: BorderRadius.circular(AppDimen.p12)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: size.isMobile ? AppDimen.p16 : AppDimen.p24,
              horizontal: size.isMobile ? AppDimen.p16 : AppDimen.p64,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Votre épicerie en ligne pour",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.greenColor),
                    ),
                    Text(
                      "expérience gourmande",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.greenColor),
                    ),
                    SizedBox(
                        height: size.isMobile ? AppDimen.p16 : AppDimen.p32),
                    MButton(
                      text: "Acheter maintenant",
                      onPressed: () {},
                    )
                  ],
                ),
                kIsWeb
                    ? SvgPicture.asset('svg/vegetable-1.svg',
                        width: 350, height: 350)
                    : SvgPicture.asset('assets/svg/vegetable-1.svg',
                        width: 15, height: 15)
              ],
            ),
          ),
        ),
      );
    });
  }
}
