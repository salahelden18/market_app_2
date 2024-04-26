import 'package:equatable/equatable.dart';
import '../../../data/models/signup_model.dart';

abstract class SignupStates extends Equatable {
  const SignupStates();

  @override
  List<Object> get props => [];
}

class SigupInitialState extends SignupStates {}

class SigupLoadingState extends SignupStates {}

class SigupSuccesstate extends SignupStates {
  final SignupModel signupModel;

  const SigupSuccesstate(this.signupModel);

  @override
  List<Object> get props => [signupModel];
}

class SignupFailureState extends SignupStates {
  final String errorMessage;

  const SignupFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
