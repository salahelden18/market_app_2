import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/basket/presentation/views/widgets/basket_item_widget.dart';
import 'package:market_app_2/features/order/presentation/views/widgets/order_button_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../basket/presentation/model_views/basket_cubit.dart';
import '../../../home/presentation/view_models/branch/branch_cubit.dart';
import '../view_models/payment/payment_method_cubit.dart';
import '../view_models/payment/payment_method_states.dart';
import 'widgets/order_payment_summary.dart';
import 'widgets/order_address_section.dart';
import 'widgets/order_payment_section_method.dart';
import 'widgets/order_section.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const String routeName = '/order-screen';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool isExecuted = false;
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isExecuted) {
      // getting the payment methods if it is not fetched before to skipping getting it each time we enter here
      final paymentState = context.read<PaymentMethodCubit>();
      if (paymentState.state is! PaymentMethodSuccessState) {
        setState(() {
          isLoading = true;
        });
        await context.read<PaymentMethodCubit>().getPaymentMethods(
            context.read<BranchCubit>().state.branchModel!.id);
        setState(() {
          isLoading = false;
        });
      }

      isExecuted = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final basketState = context.watch<BasketCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      bottomNavigationBar:
          isLoading ? const SizedBox() : const OrderButtonWidget(),
      body: isLoading
          ? const LoadingWidget()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: [
                // Address Section
                const OrderSection(
                  title: 'Address',
                  widget: OrderAddressSection(),
                ),
                const SizedBox(height: 20),
                // payment method section
                const OrderSection(
                  title: 'Payment Method',
                  widget: OrderPaymentMethodWidget(),
                ),
                const SizedBox(height: 20),

                // products section
                OrderSection(
                  title: 'Products',
                  widget: Column(
                    children: List.generate(
                      basketState.state.basket!.basketProducts.length,
                      (index) => basketState.state.basket!.basketProducts[index]
                                  .branchProductModel !=
                              null
                          ? Column(
                              children: [
                                BasketItemWidget(
                                  basketProductModel: basketState
                                      .state.basket!.basketProducts[index],
                                ),
                                const SizedBox(height: 10),
                              ],
                            )
                          : const SizedBox(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // payment summary section
                const OrderSection(
                  title: 'Payment Summary',
                  widget: OrderPaymentSummary(),
                ),
              ],
            ),
    );
  }
}
