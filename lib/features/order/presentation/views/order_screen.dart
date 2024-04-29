import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/loading_widget.dart';
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
      setState(() {
        isLoading = true;
      });
      // getting the payment methods if it is not fetched before to skipping getting it each time we enter here
      final paymentState = context.read<PaymentMethodCubit>();
      if (paymentState.state is! PaymentMethodSuccessState) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: isLoading
          ? const LoadingWidget()
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: const [
                // Address Section
                OrderSection(
                  title: 'Address',
                  widget: OrderAddressSection(),
                ),
                SizedBox(height: 20),
                // payment method section
                OrderSection(
                  title: 'Payment Method',
                  widget: OrderPaymentMethodWidget(),
                ),
                SizedBox(height: 20),

                // products section
                // TODO add the products seciton here
                // payment summary section
                OrderSection(
                  title: 'Payment Summary',
                  widget: OrderPaymentSummary(),
                ),
              ],
            ),
    );
  }
}
