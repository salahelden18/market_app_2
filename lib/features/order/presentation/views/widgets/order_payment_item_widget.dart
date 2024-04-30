import 'package:flutter/material.dart';

class OrderPaymentItemWidget extends StatelessWidget {
  const OrderPaymentItemWidget(
      {super.key,
      required this.price,
      required this.title,
      this.isYouSaved = false});
  final String title;
  final double price;
  final bool isYouSaved;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isYouSaved ? Colors.green : Colors.black87),
        ),
        Text(
          '${isYouSaved ? '🎉' : ''}  $price ₺',
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isYouSaved ? Colors.green : Colors.black87),
        ),
      ],
    );
  }
}
