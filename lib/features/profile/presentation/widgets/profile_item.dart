import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';

// ignore: must_be_immutable
class ProfileItem extends StatelessWidget {
  String title;
  final IconData icon;
  Function onTap;
  bool isButton;

  ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: isButton
          ? AppColors.primaryColor.withOpacity(.1)
          : Colors.transparent,
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: 42,
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          child: Row(
            children: [
              Icon(
                icon,
                size: 25,
                color: AppColors.primaryColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (isButton) const Spacer(),
              if (isButton)
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.black.withOpacity(.7),
                  size: 15,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
