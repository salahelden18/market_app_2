import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../favorite/presentation/views/favorite_screen.dart';
import '../../../../basket/presentation/views/basket_screen.dart';
import '../../../../profile/profile_screen.dart';
import '../../views/widgets/home_screen_layout.dart';

class BottomNavBarCubit extends Cubit<int> {
  BottomNavBarCubit() : super(0);

  List<BottomNavigationBarItem> get navbarItems => [
        const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), label: 'Home'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined), label: 'Basket'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined), label: 'Favorite'),
        const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ];

  List<Widget> get pages => [
        const HomeScreenLayout(),
        const BasketScreen(),
        const FavoriteScreen(),
        const ProfileScreen()
      ];

  onTap(int index) {
    emit(index);
  }
}
