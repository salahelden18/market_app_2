import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/home/presentation/view_models/bottm_nav_bar_cubit/bottom_nav_bar_cubit.dart';

class NavBar extends StatefulWidget {
  const NavBar(
    this.context, {
    super.key,
  });

  final BuildContext context;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    final navBar = context.watch<BottomNavBarCubit>();
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
            onTabChange: (currentIndex) {
              if (currentIndex == 1) {
                // Navigator.of(context).pushNamed(SearchScreen.routeName);
              }
              navBar.onTap(currentIndex);
            },
            rippleColor: AppColors.primaryColor.withOpacity(.2),
            tabBorderRadius: 10,
            duration: const Duration(milliseconds: 250),
            gap: 5,
            color: AppColors.primaryColor,
            activeColor: AppColors.primaryColor,
            iconSize: 25,
            tabBackgroundColor: AppColors.primaryColor.withOpacity(.1),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
            tabs: navBar.navbarItems,
          ),
        ),
      ),
    );
  }
}
