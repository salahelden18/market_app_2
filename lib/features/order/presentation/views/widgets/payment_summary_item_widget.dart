import 'package:flutter/material.dart';

class PaymentSummaryItemWidget extends StatelessWidget {
  const PaymentSummaryItemWidget({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
    this.isGreen = false,
  });
  final String title;
  final String value;
  final bool isTotal;
  final bool isGreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isGreen ? Colors.green : Colors.black87),
        ),
        Text(
          value,
          style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isGreen ? Colors.green : Colors.black87),
        ),
      ],
    );
  }
}
