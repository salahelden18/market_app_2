import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../basket/presentation/model_views/basket_cubit.dart';
import '../../../../home/presentation/view_models/branch/branch_cubit.dart';
import 'order_payment_item_widget.dart';

class OrderPaymentSummary extends StatelessWidget {
  const OrderPaymentSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final branch = context.read<BranchCubit>();
    final basket = context.read<BasketCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderPaymentItemWidget(
          price: basket.state.basket!.totalPrice,
          title: 'Sub Total',
        ),
        const SizedBox(height: 10),
        OrderPaymentItemWidget(
          price: branch.state.branchModel?.deliveryFees ?? 0.0,
          title: 'Delivery Fees',
        ),
        const SizedBox(height: 10),
        const OrderPaymentItemWidget(
          isYouSaved: true,
          price: 0.0,
          title: 'You Saved',
        ),
        const SizedBox(height: 5),
        const Divider(),
        const SizedBox(height: 5),
        OrderPaymentItemWidget(
          price: basket.state.basket!.totalPrice +
              (branch.state.branchModel?.deliveryFees ?? 0.0),
          title: 'Total Price',
        ),
        
      ],
    );
  }
}
