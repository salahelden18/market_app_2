import 'package:equatable/equatable.dart';

import '../../../data/models/order_model.dart';

abstract class OrderDetailsStates extends Equatable {
  const OrderDetailsStates();

  @override
  List<Object> get props => [];
}

class OrderDetailsInitialState extends OrderDetailsStates {}

class OrderDetailsLoadingState extends OrderDetailsStates {}

class OrderDetailsSuccessState extends OrderDetailsStates {
  final OrderModel order;

  const OrderDetailsSuccessState(this.order);

  @override
  List<Object> get props => [order];
}

class OrderDetailsFailureState extends OrderDetailsStates {
  final String errorMessage;

  const OrderDetailsFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
