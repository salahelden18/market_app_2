import 'package:equatable/equatable.dart';

import '../../../data/models/payment_method_model.dart';

abstract class PaymentMethodStates extends Equatable {
  const PaymentMethodStates();

  @override
  List<Object> get props => [];
}

class PaymentMethodInitialState extends PaymentMethodStates {}

class PaymentMethodLoadingState extends PaymentMethodStates {}

class PaymentMethodSuccessState extends PaymentMethodStates {
  final List<PaymentMethodModel> payments;

  const PaymentMethodSuccessState(this.payments);
  @override
  List<Object> get props => [payments];
}

class PaymentMethodFailureState extends PaymentMethodStates {
  final String errorMessage;

  const PaymentMethodFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
