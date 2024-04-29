import 'package:flutter/material.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../data/models/order_lottie_model.dart';
import '../../../data/models/order_model.dart';
import 'order_tracking_item.dart';

class OrderTrackingWidget extends StatelessWidget {
  const OrderTrackingWidget(
      {super.key,
      required this.order,
      required this.currentIndex,
      required this.lotties});
  final OrderModel order;
  final int currentIndex;
  final List<OrderLottieModel> lotties;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 50,
        height: 5,
        color: currentIndex >= 0 ? AppColors.primaryColor : AppColors.lightGray,
      ),
      ...List.generate(
        4,
        (index) => Flexible(
          flex: index == 0 ? 0 : 1,
          child: OrderTrackingItemWidget(
            isSelected: currentIndex >= index,
            orderLottieModel: lotties[index],
            isLastIndex: index == 3,
            isFirstIndex: index == 0,
          ),
        ),
      ),
      Container(
        width: 50,
        height: 5,
        color: currentIndex == 3 ? AppColors.primaryColor : AppColors.lightGray,
      ),
    ]);
  }
}
