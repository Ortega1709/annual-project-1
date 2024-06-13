import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: "Helvetica",
    colorScheme: const ColorScheme.light(primary: AppColor.primaryColor),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColor.backgroundColor,
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColor.backgroundColor,
      backgroundColor: AppColor.backgroundColor,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: 1,
      backgroundColor: AppColor.whiteColor,
      selectedIconTheme: IconThemeData(color: AppColor.primaryColor),
      selectedLabelStyle: TextStyle(color: AppColor.primaryColor),
      unselectedIconTheme: IconThemeData(color: AppColor.greyColor),
      unselectedLabelStyle: TextStyle(color: AppColor.greyColor),
    ),
  );
}
