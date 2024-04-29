import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/widget/filled_button_widget.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/order/presentation/views/order_screen.dart';

class ButtonBottomNavigationBar extends StatelessWidget {
  const ButtonBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final basket = context.watch<BasketCubit>();
    return basket.state.basket != null &&
            basket.state.basket?.basketProducts != null &&
            basket.state.basket!.basketProducts.isNotEmpty
        ? Container(
            height: 70,
            padding: const EdgeInsets.all(10),
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
            child: FilledButtonWidget(
              onPress: () {
                // TODO make check to see if the user is authenticated or not
                Navigator.of(context).pushNamed(OrderScreen.routeName);
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
          )
        : const SizedBox();
  }
}
