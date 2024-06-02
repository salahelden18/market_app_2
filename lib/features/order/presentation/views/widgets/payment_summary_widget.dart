import 'package:flutter/material.dart';

import '../../../data/models/order_model.dart';
import 'payment_summary_item_widget.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentSummaryItemWidget(
          title: 'Sub Total',
          value: '${order.totalPrice.toString()} ₺',
        ),
        const SizedBox(height: 10),
        PaymentSummaryItemWidget(
          title: 'Delivery Fees',
          value: '${order.deliveryFees.toString()} ₺',
        ),
        const SizedBox(height: 10),
        // const PaymentSummaryItemWidget(
        //   isGreen: true,
        //   title: 'You Saved',
        //   value: '🎉  0 ₺',
        // ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
        PaymentSummaryItemWidget(
          title: 'Total',
          value: "${order.totalPrice + order.deliveryFees}",
        ),
      ],
    );
  }
}
