import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:market_app_2/core/style/app_colors.dart';

class NavBar extends StatelessWidget {
  const NavBar(
    this.context,
    this.navBar, {
    super.key,
  });

  final BuildContext context;
  final dynamic navBar;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 10,
            start: 10,
            end: 10,
            bottom: 15,
          ),
          child: GNav(
              selectedIndex: navBar.state,
              onTabChange: navBar.onTap,
              rippleColor: AppColors.primaryColor.withOpacity(.2),
              tabBorderRadius: 10,
              duration: const Duration(milliseconds: 250),
              gap: 5,
              color: AppColors.primaryColor,
              activeColor: AppColors.primaryColor,
              iconSize: 25,
              tabBackgroundColor: AppColors.primaryColor.withOpacity(.1),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              tabs: navBar.navbarItems),
        ),
      ),
    );
  }
}
