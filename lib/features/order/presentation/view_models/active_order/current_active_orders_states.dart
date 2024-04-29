import 'package:equatable/equatable.dart';

import '../../../data/models/order_model.dart';

abstract class CurrentActiveOrdersStates extends Equatable {
  const CurrentActiveOrdersStates();

  @override
  List<Object> get props => [];
}

class CurrentActiveOrderInitialState extends CurrentActiveOrdersStates {}

class CurrentActiveOrderSuccessState extends CurrentActiveOrdersStates {
  final List<OrderModel> orders;

  const CurrentActiveOrderSuccessState(this.orders);

  @override
  List<Object> get props => [orders];
}

class CurrentActiveOrderFailureState extends CurrentActiveOrdersStates {
  final String errorMessage;

  const CurrentActiveOrderFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
