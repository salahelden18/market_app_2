import 'package:flutter/material.dart';

import '../../../../order/data/models/order_model.dart';
import '../../../../order/presentation/views/order_tracking_screen.dart';

class ActiveOrderListItemWidget extends StatelessWidget {
  const ActiveOrderListItemWidget({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(OrderTrackingScreen.routeName,
              arguments: orderModel.id);
        },
        splashColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderModel.orderStatusModel!.enName!),
                  if (orderModel.orderStatusModel?.enDesc != null)
                    const SizedBox(height: 10),
                  if (orderModel.orderStatusModel?.enDesc != null)
                    Text(orderModel.orderStatusModel!.enDesc!),
                ],
              ),
              const Icon(Icons.arrow_forward_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
