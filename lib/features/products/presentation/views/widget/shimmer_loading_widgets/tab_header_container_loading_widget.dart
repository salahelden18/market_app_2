import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/widget/shimmer_loading_widget.dart';

class TabHeaderContainerLoadingWidget extends StatelessWidget {
  const TabHeaderContainerLoadingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return ShimmerLoadingWidget(
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey),
      ),
    );
  }
}
