import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/order/data/models/order_model.dart';

abstract class AddOrderStates extends Equatable {
  const AddOrderStates();

  @override
  List<Object> get props => [];
}

class AddOrderInitialState extends AddOrderStates {}

class AddOrderLoadingState extends AddOrderStates {}

class AddOrderSuccessState extends AddOrderStates {
  final OrderModel orderModel;

  const AddOrderSuccessState(this.orderModel);

  @override
  List<Object> get props => [orderModel];
}

class AddOrderFailureState extends AddOrderStates {
  final String errorMessage;

  const AddOrderFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
