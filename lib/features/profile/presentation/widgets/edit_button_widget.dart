import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:market_app_2/core/style/app_colors.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 15,
            vertical: 5,
          ),
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                bottomEnd: Radius.circular(10),
              )),
          child: const Text(
            'Edit',
            style: TextStyle(color: AppColors.white),
          )),
    );
  }
}
