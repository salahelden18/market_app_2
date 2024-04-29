import 'package:flutter/material.dart';

import '../../../../../core/style/app_colors.dart';

class OrderNameValueWidget extends StatelessWidget {
  const OrderNameValueWidget({
    super.key,
    required this.text,
    required this.value,
    this.textColor,
  });

  final String text;
  final String value;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: [
        TextSpan(
            text: '$text: ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            )),
        TextSpan(
          text: value,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: textColor ?? Colors.black,
          ),
        ),
      ],
    ));
  }
}
