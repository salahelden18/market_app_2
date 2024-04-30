import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../basket/presentation/views/widgets/basket_item_widget.dart';
import 'widgets/order_button_widget.dart';
import 'widgets/order_container_widget.dart';
import '../../../../core/widget/loading_widget.dart';
import '../../../basket/presentation/model_views/basket_cubit.dart';
import '../../../home/presentation/view_models/branch/branch_cubit.dart';
import '../view_models/payment/payment_method_cubit.dart';
import '../view_models/payment/payment_method_states.dart';
import 'widgets/order_payment_summary.dart';
import 'widgets/order_address_section.dart';
import 'widgets/order_payment_section_method.dart';

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
                const SizedBox(height: 10),
                // Address Section
                const OrderContainerWidget(
                  title: 'Address',
                  widget: OrderAddressSection(),
                ),
                const SizedBox(height: 20),
                // payment method section
                const OrderContainerWidget(
                  title: 'Payment Method',
                  widget: OrderPaymentMethodWidget(),
                ),
                const SizedBox(height: 20),

                // products section
                OrderContainerWidget(
                  title: 'Products',
                  widget: Column(
                    children: List.generate(
                      basketState.state.basket?.basketProducts.length ?? 0,
                      (index) => basketState.state.basket != null &&
                              basketState.state.basket!.basketProducts[index]
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
                const OrderContainerWidget(
                  title: 'Payment Summary',
                  widget: OrderPaymentSummary(),
                ),
              ],
            ),
    );
  }
}
