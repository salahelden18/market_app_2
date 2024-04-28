import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/nav_bar_widget.dart';
import '../view_models/bottm_nav_bar_cubit/bottom_nav_bar_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final navBar = context.watch<BottomNavBarCubit>();
    return Scaffold(
      bottomNavigationBar: NavBar(context, navBar),
      body: navBar.pages[navBar.state],
    );
  }
}
