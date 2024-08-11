import 'package:e_commerce/core/theme/app_color.dart';
import 'package:e_commerce/core/theme/app_dimen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void productFilterDialog(BuildContext context, List<Widget> widgets) {
  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppDimen.p16),
        topRight: Radius.circular(AppDimen.p16),
      ),
    ),
    backgroundColor: AppColor.whiteColor,
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Trier par",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  FontAwesomeIcons.xmark,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(height: AppDimen.p16),
            ...widgets,
            const SizedBox(height: AppDimen.p16)
          ],
        ),
      );
    },
  );
}
