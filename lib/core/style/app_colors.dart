import 'package:flutter/material.dart';

class AppColors {
  // Orange
  static const Color primaryColor = Color(0xff025959);
  static Color secondColor = const Color(0xffFA7F08);
  static Color thirdColor = const Color(0xff9EF8EE);
  static Color fourthColor = const Color(0xff22BABB);
  // Gray
  static Color fifthColor = const Color(0xffE2E2E2);
  // Red
  static const Color errorColor = Color(0xff850101);
  // Green
  static const Color successColor = Color(0xff056608);
  // Yellow
  static Color warningColor = const Color(0xffF6BE00);

  // Additional colors
  static const Color textColor = Colors.black;
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static Color lightPrimaryColor = AppColors.primaryColor.withOpacity(.07);
  static Color lightGray = Colors.grey.withOpacity(.5);
}
