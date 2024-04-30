import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/address/presentation/model_views/address_cubit.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/order/presentation/view_models/active_order/current_active_orders_cubit.dart';
import 'package:market_app_2/features/profile/presentation/model_views/profile_cubit.dart';
import 'package:market_app_2/main.dart';
import '../../../../../core/constants/string_constants.dart';
import '../../../../../core/services/shared_preferences_service.dart';
import 'auto_authentication_state.dart';

class AutoAuthenticationCubit extends Cubit<AutoAuthenticationState> {
  AutoAuthenticationCubit(this._sharedPreferencesService)
      : super(const AutoAuthenticationState(AuthenticationStates.initial));

  final SharedPreferencesService _sharedPreferencesService;

  Future authenticateUser() async {
    print('---------------------------------');
    print('Executing Executing');
    print('---------------------------------');
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

  Future signout() async {
    await _sharedPreferencesService.clearData();

    navigatorKey.currentContext!.read<ProfileCubit>().reset();
    navigatorKey.currentContext!.read<AddressCubit>().reset();
    navigatorKey.currentContext!.read<BasketCubit>().reset();
    navigatorKey.currentContext!.read<CurrentActiveOrderCubit>().reset();

    emit(state.copyWith(
        authenticationState: AuthenticationStates.notAuthenticated));
  }
}
