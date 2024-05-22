import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/widget/shimmer_loading_widget.dart';

class ProductGridViewLoadingItemWidget extends StatelessWidget {
  const ProductGridViewLoadingItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShimmerLoadingWidget(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Colors.white,
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(.7),
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
