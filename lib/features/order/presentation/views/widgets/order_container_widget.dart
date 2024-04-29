import 'package:flutter/material.dart';

import '../../../../../core/style/app_colors.dart';

class OrderContainerWidget extends StatelessWidget {
  const OrderContainerWidget({super.key, this.title, required this.widget});
  final String? title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        if (title != null) const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.lightGray),
          ),
          child: widget,
        ),
      ],
    );
  }
}
