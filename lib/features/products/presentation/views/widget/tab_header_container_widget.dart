import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';

class TabHeaderContainerWidget extends StatelessWidget {
  const TabHeaderContainerWidget(
      {super.key,
      required this.isSelected,
      required this.title,
      required this.isEnabled});
  final bool isSelected;
  final String title;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
        color: isEnabled
            ? isSelected
                ? AppColors.primaryColor
                : Colors.white
            : Colors.grey[400],
      ),
      child: Text(
        title,
        style: TextStyle(
            color: isSelected ? Colors.white : AppColors.primaryColor),
      ),
    );
  }
}
