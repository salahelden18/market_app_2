import 'package:flutter/material.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/font_style.dart';

class OrderSection extends StatelessWidget {
  const OrderSection({super.key, required this.title, required this.widget});
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontStyle.size22Black600,
        ),
        const SizedBox(height: 10),
        Container(
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
