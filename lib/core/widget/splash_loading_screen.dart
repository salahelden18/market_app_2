import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';

class SplashLoadingScreen extends StatelessWidget {
  const SplashLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 3.14,
            child: LinearProgressIndicator(
              backgroundColor: AppColors.primaryColor,
              color: AppColors.warningColor,
            ),
          ),
          Image.asset('assets/images/ss_market_logo.png'),
          LinearProgressIndicator(
            backgroundColor: AppColors.primaryColor,
            color: AppColors.warningColor,
          ),
        ],
      ),
    );
  }
}
