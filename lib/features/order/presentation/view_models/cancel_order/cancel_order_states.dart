import 'package:equatable/equatable.dart';

import '../../../data/models/order_status_model.dart';

abstract class CancelOrderStates extends Equatable {
  const CancelOrderStates();
  @override
  List<Object> get props => [];
}

class CancelOrderInitialState extends CancelOrderStates {}

class CancelOrderLoadingState extends CancelOrderStates {}

class CancelOrderSuccessState extends CancelOrderStates {
  final OrderStatusModel orderStatus;

  const CancelOrderSuccessState(this.orderStatus);

  @override
  List<Object> get props => [orderStatus];
}

class CancelOrderFailureState extends CancelOrderStates {
  final String errorMessage;

  const CancelOrderFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
