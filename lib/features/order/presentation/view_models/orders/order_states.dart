import 'package:equatable/equatable.dart';

abstract class OrderStates extends Equatable {
  const OrderStates();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderStates {}

class OrderLoadingState extends OrderStates {}

class OrderSuccessState extends OrderStates {}

class OrderFailureState extends OrderStates {
  final String errorMessage;

  const OrderFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
