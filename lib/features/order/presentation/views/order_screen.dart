import 'package:flutter/material.dart';
import 'package:market_app_2/features/order/presentation/views/widgets/order_address_section.dart';
import 'package:market_app_2/features/order/presentation/views/widgets/order_payment_section_method.dart';
import 'package:market_app_2/features/order/presentation/views/widgets/order_section.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  static const String routeName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          // Address Section
          const OrderSection(
            title: 'Address',
            widget: OrderAddressSection(),
          ),
          // payment method section
          OrderSection(
            title: 'Payment Method',
            widget: OrderPaymentMethodWidget(),
          ),
          // products section
          // TODO add the products seciton here
          // payment summary section
        ],
      ),
    );
  }
}
