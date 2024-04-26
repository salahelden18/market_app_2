import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/services/shared_preferences_service.dart';
import 'auto_authentication_state.dart';

class AutoAuthenticationCubit extends Cubit<AutoAuthenticationState> {
  AutoAuthenticationCubit(this._sharedPreferencesService)
      : super(const AutoAuthenticationState(AuthenticationStates.initial));

  final SharedPreferencesService _sharedPreferencesService;

  Future authenticateUser() async {
    emit(state.copyWith(authenticationState: AuthenticationStates.loading));

    var token =
        await _sharedPreferencesService.getData<String>(StringConstants.token);

    if (token != null && token.isNotEmpty) {
      emit(state.copyWith(
          authenticationState: AuthenticationStates.authenticated));
    } else {
      emit(state.copyWith(
          authenticationState: AuthenticationStates.notAuthenticated));
    }
  }
}
