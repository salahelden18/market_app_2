import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/utils/dialog_manager_overlay.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/features/address/presentation/model_views/address_cubit.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/home/presentation/views/home_screen.dart';
import 'package:market_app_2/features/order/data/models/order_request_model.dart';
import 'package:market_app_2/features/order/presentation/view_models/orders/add_order_cubit.dart';
import 'package:market_app_2/features/order/presentation/view_models/orders/add_order_states.dart';
import 'package:market_app_2/features/order/presentation/view_models/payment/payment_method_cubit.dart';
import 'package:market_app_2/features/order/presentation/view_models/payment/payment_method_states.dart';

import '../../../../../core/widget/filled_button_widget.dart';

class OrderButtonWidget extends StatelessWidget {
  const OrderButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddOrderCubit, AddOrderStates>(
      listener: (context, state) {
        if (state is AddOrderLoadingState) {
          DialogManagerOverlay.showDialogWithMessage(context);
        } else if (state is AddOrderFailureState) {
          DialogManagerOverlay.closeDialog();
          showToast(context: context, msg: state.errorMessage);
        } else if (state is AddOrderSuccessState) {
          // TODO call active orders, basket
          DialogManagerOverlay.closeDialog();
          Navigator.of(context)
              .popUntil((route) => route.settings.name == HomeScreen.routeName);
        }
      },
      child: Container(
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
            var orderRequestModel = OrderRequestModel(
              addressId: context.read<AddressCubit>().state.selectedAddress!.id,
              basketId: context.read<BasketCubit>().state.basket!.id,
              paymentMethodId: (context.read<PaymentMethodCubit>().state
                      as PaymentMethodSuccessState)
                  .payments[0]
                  .id,
            );

            context.read<AddOrderCubit>().order(orderRequestModel);
          },
          widget: const Text('Order'),
        ),
      ),
    );
  }
}
