import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/authentication/data/models/forgot_password_model.dart';
import 'package:market_app_2/features/authentication/data/repos/authentication_repo.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/forgot_password/forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordStates> {
  ForgotPasswordCubit(this._authenticationRepo)
      : super(ForgotPasswordInitialState());

  final AuthenticationRepo _authenticationRepo;

  Future forgotPassword(ForgotPasswordModel forgotPasswordModel) async {
    emit(ForgotPasswordLoadingState());

    var result = await _authenticationRepo.forgotPassword(forgotPasswordModel);

    result.fold((l) => emit(ForgotPasswordFailureState(l.message)),
        (r) => emit(ForgotPasswordSuccessState(r!)));
  }
}
