import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/order/presentation/view_models/order_details_cubit.dart/order_details_cubit.dart';
import 'package:market_app_2/service_locator.dart';
import '../view_models/order_history_cubit.dart';
import '../view_models/order_hsitory_states.dart';
import 'order_tracking_screen.dart';
import 'widgets/order_item_widget.dart';

class OrdersHistoryScreen extends StatefulWidget {
  const OrdersHistoryScreen({super.key});
  static const String routeName = '/orders-history';

  @override
  State<OrdersHistoryScreen> createState() => _OrdersHistoryScreenState();
}

class _OrdersHistoryScreenState extends State<OrdersHistoryScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    // first fetching
    context.read<OrderHistoryCubit>().getOrders();

    // fetching when reaching to the end of the screen
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<OrderHistoryCubit>().getOrders(false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryStates>(
        builder: (ctx, state) {
          if (state is OrderHistoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OrderHistorySuccessState) {
            if (state.orders.isEmpty) {
              return const Center(
                child: Text('You Don\'t Have Any Orders'),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemBuilder: (ctx, index) {
                if (index < state.orders.length) {
                  final order = state.orders[index];

                  return InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MultiBlocProvider(providers: [
                            BlocProvider.value(
                                value: context.read<OrderHistoryCubit>()),
                            BlocProvider(
                                create: (ctx) => OrderDetailsCubit(sl())),
                          ], child: const OrderTrackingScreen()),
                          settings: RouteSettings(arguments: order.id),
                        ),
                      );
                    },
                    child: OrderItemWidget(
                      order: order,
                    ),
                  );
                } else {
                  return context.read<OrderHistoryCubit>().hasMore
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : const SizedBox();
                }
              },
              itemCount: state.orders.length + 1,
            );
          } else {
            final String message;
            if (state is OrderHistoryFailureState) {
              message = state.errorMessage;
            } else {
              message = "error";
            }

            return Center(
              child: Text(message),
            );
          }
        },
      ),
    );
  }
}
