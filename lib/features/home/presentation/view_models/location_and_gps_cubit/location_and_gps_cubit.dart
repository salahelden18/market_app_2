import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/models/current_location_model.dart';
import '../../../../../core/services/location_service_interface.dart';
import 'location_and_gps_states.dart';

class LocationAndGpsCubit extends Cubit<LocationAndGPSState> {
  LocationAndGpsCubit(this._locationService)
      : super(const LocationAndGPSState());
  final LocationServiceInterface _locationService;

  Future checkingServices() async {
    try {
      print('entered checking services');
      emit(state.copyWith(isLoading: true));

      if (!await (_locationService.isServiceEnabled())) {
        emit(state.copyWith(isLoading: false, isServiceEnabled: false));
        return;
      }

      if (!await (_locationService.checkPermissions())) {
        emit(state.copyWith(
          isLoading: false,
          hasPermission: false,
          isServiceEnabled: true,
        ));
        return;
      }

      CurrentLocationModel? currentLocationModel =
          await _locationService.getCurrentUserLocation();

      emit(state.copyWith(
        isLoading: false,
        isServiceEnabled: true,
        hasPermission: true,
        currentLocation: currentLocationModel,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
