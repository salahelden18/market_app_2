import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../service_locator.dart';
import '../view_models/active_order/current_active_orders_cubit.dart';
import '../view_models/cancel_order/cancel_order_cubit.dart';
import '../view_models/order_details_cubit.dart/order_details_cubit.dart';
import '../view_models/order_details_cubit.dart/order_details_states.dart';
import 'widgets/cancel_lottie_widget.dart';
import '../../../../core/constants/animation_constants.dart';
import '../../data/models/order_lottie_model.dart';
import 'widgets/cancel_order_button.dart';
import 'widgets/lottie_container_widget.dart';
import 'widgets/order_movements_widget.dart';
import 'widgets/order_product_item_widget.dart';
import 'widgets/order_tracking_widget.dart';
import 'widgets/order_container_widget.dart';

import 'widgets/payment_summary_widget.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});
  static const String routeName = '/order-tracking-screen';

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  bool didLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!didLoaded) {
      final orderId = ModalRoute.of(context)?.settings.arguments as String;

      context.read<OrderDetailsCubit>().getOrderDetails(orderId);
      didLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Tracking')),
      body: BlocConsumer<OrderDetailsCubit, OrderDetailsStates>(
        listener: (context, state) {
          if (state is OrderDetailsSuccessState) {
            if (state.order.loadCurrentActiveOrders == true) {
              context.read<CurrentActiveOrderCubit>().getActiveOrders();
            }
          }
        },
        builder: (context, state) {
          if (state is OrderDetailsLoadingState) {
            return const LoadingWidget();
          } else if (state is OrderDetailsSuccessState) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                !isOrderCancel(state.order.orderStatusModel!.enName!)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // order tracking
                          OrderTrackingWidget(
                            order: state.order,
                            currentIndex:
                                getIndex(state.order.orderStatusModel!.enName!),
                            lotties: getOrderTrackingList(),
                          ),
                          const SizedBox(height: 70),
                          // Cancel Section
                          if (showCancelButton(
                              state.order.orderStatusModel!.enName!))
                            BlocProvider(
                              create: (ctx) => CancelOrderCubit(sl()),
                              child: CancelOrderButton(orderId: state.order.id),
                            ),
                          if (showCancelButton(
                              state.order.orderStatusModel!.enName!))
                            const SizedBox(height: 20),
                          // lottie file
                          OrderContainerWidget(
                            widget: LottieContainerWidget(
                              lottie: getOrderTrackingList()[getIndex(
                                  state.order.orderStatusModel!.enName!)],
                            ),
                          ),
                        ],
                      )
                    : OrderContainerWidget(
                        widget: CancelLottieWidget(
                          title: state.order.orderStatusModel!.enName!,
                        ),
                      ),
                const SizedBox(height: 20),

                // Address Part
                OrderContainerWidget(
                  title: 'Address',
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primaryColor,
                      ),
                      const SizedBox(width: 8),
                      Text('${state.order.addressModel?.fullAddress}'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // products section
                OrderContainerWidget(
                  title: 'Products',
                  widget: Column(
                    children: List.generate(
                      state.order.basketModel!.basketProducts.length,
                      (index) => Column(
                        children: [
                          OrderProductItemWidget(
                            basketProductModel:
                                state.order.basketModel!.basketProducts[index],
                          ),
                          if (index !=
                              state.order.basketModel!.basketProducts.length -
                                  1)
                            const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Payment Summary
                OrderContainerWidget(
                  title: 'Payment Summary',
                  widget: PaymentSummaryWidget(order: state.order),
                ),
                const SizedBox(height: 20),
                // order movement part
                OrderContainerWidget(
                  title: 'Order Movements',
                  widget: OrderMovementsWidget(
                    orderEvents: state.order.orderEvents,
                  ),
                ),
              ],
            );
          } else {
            String errorMessage = state is OrderDetailsFailureState
                ? state.errorMessage
                : 'error';
            return Center(
              child: Text(errorMessage),
            );
          }
        },
      ),
    );
  }

  bool showCancelButton(String status) {
    final statusText = status.toLowerCase();

    if (statusText == 'sent' || statusText == 'accepted') {
      return true;
    }

    return false;
  }

  bool isOrderCancel(String status) {
    status = status.toLowerCase();
    return status.startsWith('canceled');
  }

  getOrderTrackingList() {
    return [
      const OrderLottieModel(
        description: 'Your order is being reviewed',
        lottieFile: AnimationConstants.reviewing,
        title: 'Reviewing Your Order',
      ),
      const OrderLottieModel(
        description: 'Your order is being Prepared',
        lottieFile: AnimationConstants.preparing,
        title: 'Preparing Your Order',
      ),
      const OrderLottieModel(
        description: 'Your order is on the way',
        lottieFile: AnimationConstants.delivering,
        title: 'Out For Delivery',
      ),
      const OrderLottieModel(
        description: 'Enjoy your meal',
        lottieFile: AnimationConstants.delivered,
        title: 'Delivered',
      ),
    ];
  }

  int getIndex(String status) {
    status = status.toLowerCase();

    if (status == 'sent' || status == 'accepted') {
      return 0;
    } else if (status == 'delayed' || status == 'preparing') {
      return 1;
    } else if (status == 'out for delivery') {
      return 2;
    } else {
      return 3;
    }
  }
}
