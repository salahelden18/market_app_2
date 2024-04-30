import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:market_app_2/features/order/presentation/views/orders_history_screen.dart';
import '../../../../favorite/presentation/views/favorite_screen.dart';
import '../../../../profile/presentation/profile_screen.dart';
import '../../views/widgets/home_screen_layout.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0);

  List<GButton> get navbarItems => [
        const GButton(icon: Icons.home_outlined, text: 'Home'),
        const GButton(icon: Icons.shopping_bag_outlined, text: 'Orders'),
        const GButton(icon: Icons.favorite_outline, text: 'Favorites'),
        const GButton(icon: Icons.person_outline, text: 'Profile')
      ];

  List<Widget> get pages => [
        const HomeScreenLayout(),
        const OrdersHistoryScreen(),
        const FavoriteScreen(),
        const ProfileScreen()
      ];

  onTap(int index) {
    emit(index);
  }
}
