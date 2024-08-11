import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../theme/app_color.dart';
import '../../theme/app_dimen.dart';

class Progress extends StatelessWidget {
  final double size;
  final Color color;
  const Progress({
    super.key,
    this.color = AppColor.transparentColor,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(AppDimen.p12),
      ),
      child: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
            color: AppColor.primaryColor, size: size / 2),
      ),
    );
  }
}
