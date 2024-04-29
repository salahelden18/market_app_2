import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/category_section.dart';

import '../../../../order/presentation/view_models/active_order/current_active_orders_cubit.dart';
import '../../../../order/presentation/view_models/active_order/current_active_orders_states.dart';
import 'active_order_list_item_widget.dart';

class ActiveOrderSection extends StatelessWidget {
  const ActiveOrderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentActiveOrderCubit, CurrentActiveOrdersStates>(
      builder: (context, state) {
        if (state is CurrentActiveOrderSuccessState &&
            state.orders.isNotEmpty) {
          return CategorySection(
            title: 'Active Orders',
            widget: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...List.generate(
                  state.orders.length,
                  (index) => ActiveOrderListItemWidget(
                      orderModel: state.orders[index]),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
