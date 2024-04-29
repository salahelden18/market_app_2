import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../../basket/presentation/model_views/basket_cubit.dart';
import '../../../../basket/presentation/views/basket_screen.dart';

class BasketBadgeWidget extends StatelessWidget {
  const BasketBadgeWidget({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final basketCubit = context.watch<BasketCubit>();

    return Badge(
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
        icon: Icon(
          Icons.shopping_cart_outlined,
          color: color ?? AppColors.primaryColor,
        ),
      ),
    );
  }
}
