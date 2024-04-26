import 'package:flutter/material.dart';
import 'app_colors.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    centerTitle: true,
    foregroundColor: Colors.white,
  ),
);
