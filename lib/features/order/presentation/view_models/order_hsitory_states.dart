import 'package:equatable/equatable.dart';

import '../../data/models/order_model.dart';

abstract class OrderHistoryStates extends Equatable {
  const OrderHistoryStates();
  @override
  List<Object> get props => [];
}

class OrderHistoryInitialState extends OrderHistoryStates {}

class OrderHistoryLoadingState extends OrderHistoryStates {}

class OrderHistorySuccessState extends OrderHistoryStates {
  final List<OrderModel> orders;

  const OrderHistorySuccessState(this.orders);

  @override
  List<Object> get props => [orders];
}

class OrderHistoryFailureState extends OrderHistoryStates {
  final String errorMessage;

  const OrderHistoryFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
