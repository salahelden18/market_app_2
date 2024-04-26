import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/authentication_request_model.dart';
import '../../../data/repos/authentication_repo.dart';
import 'signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit(this._authenticationRepo) : super(SigupInitialState());

  final AuthenticationRepo _authenticationRepo;

  Future signup(AuthenticationRequestModel authenticationRequestModel) async {
    emit(SigupLoadingState());

    var result = await _authenticationRepo.signup(authenticationRequestModel);

    result.fold(
      (l) => emit(SignupFailureState(l.message)),
      (r) => emit(SigupSuccesstate(r!)),
    );
  }
}
