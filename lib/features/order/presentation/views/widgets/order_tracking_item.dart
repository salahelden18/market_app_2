import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../data/models/order_lottie_model.dart';

class OrderTrackingItemWidget extends StatelessWidget {
  const OrderTrackingItemWidget({
    super.key,
    required this.isSelected,
    required this.orderLottieModel,
    required this.isLastIndex,
    required this.isFirstIndex,
  });
  final bool isSelected;
  final bool isLastIndex;
  final bool isFirstIndex;
  final OrderLottieModel orderLottieModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isFirstIndex)
          Expanded(
            child: Container(
              height: 5,
              color: isSelected ? AppColors.primaryColor : AppColors.lightGray,
            ),
          ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isSelected ? AppColors.primaryColor : AppColors.lightGray,
              ),
            ),
            Positioned(
              left: -25,
              top: 20,
              child: SizedBox(
                  width: 80,
                  child: Text(
                    orderLottieModel.title,
                    softWrap: true,
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
