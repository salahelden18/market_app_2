import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/navigator_observer.dart';
import '../../../../../core/utils/dialog_manager_overlay.dart';
import '../../../../../core/utils/show_toast.dart';
import '../../view_models/active_order/current_active_orders_cubit.dart';
import '../../view_models/cancel_order/cancel_order_cubit.dart';
import '../../view_models/cancel_order/cancel_order_states.dart';
import '../../view_models/order_history_cubit.dart';
import '../orders_history_screen.dart';
import 'cancel_modal_sheet_widget.dart';

class CancelOrderButton extends StatelessWidget {
  const CancelOrderButton({super.key, required this.orderId});

  final String orderId;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocListener<CancelOrderCubit, CancelOrderStates>(
          listener: (ctx, state) async {
            if (state is CancelOrderLoadingState) {
              DialogManagerOverlay.showDialogWithMessage(context);
            } else if (state is CancelOrderFailureState) {
              showToast(context: context, msg: state.errorMessage);
              DialogManagerOverlay.closeDialog();
            } else if (state is CancelOrderSuccessState) {
              // if we orders screen exist in the stack update it also
              if (MyRouteObserver.containsPage(OrdersHistoryScreen.routeName)) {
                context
                    .read<OrderHistoryCubit>()
                    .updateStatus(orderId, state.orderStatus);
              }
              // call active orders again
              await context.read<CurrentActiveOrderCubit>().getActiveOrders();
              DialogManagerOverlay.closeDialog();
              if (context.mounted) {
                Navigator.pop(context);
              }
            }
          },
          child: TextButton(
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                context: context,
                builder: (ctx) => Container(
                  padding: const EdgeInsets.all(10),
                  child: BlocProvider.value(
                      value: context.read<CancelOrderCubit>(),
                      child: CancelModalSheetWidget(orderId: orderId)),
                ),
              );
            },
            child: const Text(
              'Cancel Order',
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
