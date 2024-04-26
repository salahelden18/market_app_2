import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/authentication/data/models/login_model.dart';

abstract class VerifyStates extends Equatable {
  const VerifyStates();

  @override
  List<Object> get props => [];
}

class VerifyInitialState extends VerifyStates {}

class VerifyLoadingState extends VerifyStates {}

class VerifySuccessState extends VerifyStates {
  final LoginModel loginModel;

  const VerifySuccessState(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class VerifyFailureState extends VerifyStates {
  final String errorMessage;

  const VerifyFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
