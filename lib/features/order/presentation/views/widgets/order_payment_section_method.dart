import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_models/payment/payment_method_cubit.dart';
import '../../view_models/payment/payment_method_states.dart';

class OrderPaymentMethodWidget extends StatelessWidget {
  const OrderPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final paymentState = context.watch<PaymentMethodCubit>().state;

    return paymentState is PaymentMethodSuccessState
        ? Text('Method: ${paymentState.payments[0].enName}')
        : const Text('Cash');
  }
}
