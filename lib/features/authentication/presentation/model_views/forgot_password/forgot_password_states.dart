import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/authentication/data/models/signup_model.dart';

abstract class ForgotPasswordStates extends Equatable {
  const ForgotPasswordStates();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitialState extends ForgotPasswordStates {}

class ForgotPasswordLoadingState extends ForgotPasswordStates {}

class ForgotPasswordSuccessState extends ForgotPasswordStates {
  final SignupModel signupModel;

  const ForgotPasswordSuccessState(this.signupModel);

  @override
  List<Object> get props => [signupModel];
}

class ForgotPasswordFailureState extends ForgotPasswordStates {
  final String errorMessage;

  const ForgotPasswordFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
