import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import '../../../../../core/style/font_style.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key, required this.title, required this.widget});
  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: FontStyle.size22Black600.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 20),
        widget
      ],
    );
  }
}
