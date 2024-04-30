import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/services/shared_preferences_service.dart';
import '../../../data/models/authentication_request_model.dart';
import '../../../data/repos/authentication_repo.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final AuthenticationRepo _authenticationRepo;
  final SharedPreferencesService _sharedPreferencesService;

  LoginCubit(this._authenticationRepo, this._sharedPreferencesService)
      : super(LoginInitialState());

  Future login(AuthenticationRequestModel authenticationRequestModel) async {
    emit(LoginLoadingState());

    var result = await _authenticationRepo.login(authenticationRequestModel);

    await result.fold(
      (l) async => emit(LoginFailureState(l.message)),
      (r) async {
        // if token exist save it in shared prefs
        if (r!.token != null) {
          await _sharedPreferencesService.setData<String>(
              StringConstants.token, r.token!);
        }
        // Config fcm
        await _authenticationRepo.configFCM();
        emit(LoginSuccesstate(r));
      },
    );
  }
}
