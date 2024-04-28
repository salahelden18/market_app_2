import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/basket/presentation/views/basket_screen.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/home_address_container.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final basketCubit = context.watch<BasketCubit>();
    return SafeArea(
      child: Row(
        children: [
          const Expanded(
            child: HomeAddressContainer(),
          ),
          const SizedBox(width: 20),
          Badge(
            label: Text(basketCubit.state.basket != null &&
                    basketCubit.state.basket?.basketProducts != null
                ? basketCubit.state.basket!.basketProducts.length.toString()
                : '0'),
            backgroundColor: AppColors.errorColor,
            isLabelVisible: basketCubit.state.basket != null &&
                basketCubit.state.basket?.basketProducts != null &&
                basketCubit.state.basket!.basketProducts.isNotEmpty,
            alignment: Alignment.topCenter,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(BasketScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
