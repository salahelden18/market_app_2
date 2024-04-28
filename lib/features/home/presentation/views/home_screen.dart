import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/app_colors.dart';
import '../view_models/bottm_nav_bar_cubit/bottom_nav_bar_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final navBar = context.watch<BottomNavBarCubit>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: navBar.state,
        onTap: navBar.onTap,
        items: navBar.navbarItems,
      ),
      body: navBar.pages[navBar.state],
    );
  }
}
