import 'package:flutter/material.dart';

class OrderPaymentItemWidget extends StatelessWidget {
  const OrderPaymentItemWidget(
      {super.key, required this.price, required this.title});
  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(price.toString()),
      ],
    );
  }
}
