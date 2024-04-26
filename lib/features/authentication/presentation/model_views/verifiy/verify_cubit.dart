import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/constants/string_constants.dart';
import 'package:market_app_2/core/services/shared_preferences_service.dart';
import 'package:market_app_2/features/authentication/data/models/verify_request_model.dart';
import 'package:market_app_2/features/authentication/data/repos/authentication_repo.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/verifiy/verify_state.dart';

class VerifyCubit extends Cubit<VerifyStates> {
  VerifyCubit(this._authenticationRepo, this._sharedPreferencesService)
      : super(VerifyInitialState());
  final AuthenticationRepo _authenticationRepo;
  final SharedPreferencesService _sharedPreferencesService;

  Future verify(VerifyRequestModel verifyRequestModel) async {
    emit(VerifyLoadingState());

    var result = await _authenticationRepo.verify(verifyRequestModel);

    await result.fold((l) async => emit(VerifyFailureState(l.message)),
        (r) async {
      await _sharedPreferencesService.setData<String>(
          StringConstants.token, r!.token!);

      emit(VerifySuccessState(r));
    });
  }
}
