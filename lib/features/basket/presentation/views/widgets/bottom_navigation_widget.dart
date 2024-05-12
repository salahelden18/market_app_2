import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/core/widget/filled_button_widget.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/basket/presentation/views/widgets/minimum_delivery_widget.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/order/presentation/views/order_screen.dart';

class ButtonBottomNavigationBar extends StatelessWidget {
  const ButtonBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final basket = context.watch<BasketCubit>();
    final branch = context.watch<BranchCubit>();
    return basket.state.basket != null &&
            basket.state.basket?.basketProducts != null &&
            basket.state.basket!.basketProducts.isNotEmpty
        ? Container(
            height: 130,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 7,
                  spreadRadius: 2,
                  offset: Offset(0, -1),
                )
              ],
            ),
            child: Column(
              children: [
                MinimumDeliveryWidget(
                  totalPrice: basket.state.basket!.totalPrice,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FilledButtonWidget(
                    backgroundColor: basket.state.basket!.totalPrice >=
                            branch.state.branchModel!.minimumOrderValue!
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(.6),
                    onPress: () {
                      if (basket.state.basket!.totalPrice >=
                          branch.state.branchModel!.minimumOrderValue!) {
                        Navigator.of(context).pushNamed(OrderScreen.routeName);
                      } else {
                        showToast(context: context, msg: 'Add more items');
                      }
                    },
                    widget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        const Align(
                          alignment: Alignment.center,
                          child: Text('Checkout'),
                        ),
                        Text('${basket.state.basket?.totalPrice} TL'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox();
  }
}
