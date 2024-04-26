import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/authentication/data/models/login_model.dart';

abstract class LoginStates extends Equatable {
  const LoginStates();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccesstate extends LoginStates {
  final LoginModel loginModel;

  const LoginSuccesstate(this.loginModel);

  @override
  List<Object> get props => [loginModel];
}

class LoginFailureState extends LoginStates {
  final String errorMessage;

  const LoginFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
