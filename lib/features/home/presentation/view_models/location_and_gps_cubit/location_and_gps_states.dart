import 'package:equatable/equatable.dart';
import 'package:market_app_2/core/models/current_location_model.dart';

class LocationAndGPSState extends Equatable {
  final bool isLoading;
  final bool isServiceEnabled;
  final bool hasPermission;
  final bool hasError;
  // will be used to show splash or loading
  final String? errorMessage;
  final CurrentLocationModel? currentLocation;

  const LocationAndGPSState({
    this.isLoading = false,
    this.isServiceEnabled = true,
    this.hasPermission = true,
    this.currentLocation,
    this.hasError = false,
    this.errorMessage,
  });

  LocationAndGPSState copyWith({
    bool? isLoading,
    bool? isServiceEnabled,
    bool? hasPermission,
    bool? hasError,
    String? errorMessage,
    CurrentLocationModel? currentLocation,
  }) {
    return LocationAndGPSState(
      isLoading: isLoading ?? this.isLoading,
      isServiceEnabled: isServiceEnabled ?? this.isServiceEnabled,
      hasPermission: hasPermission ?? this.hasPermission,
      currentLocation: currentLocation ?? this.currentLocation,
      hasError: hasError ?? false,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isServiceEnabled,
        hasPermission,
        currentLocation,
        isLoading,
      ];
}

// abstract class LocationAndGPSStates extends Equatable {
//   const LocationAndGPSStates();

//   @override
//   List<Object> get props => [];
// }

// class LocationAndGPSInitialState extends LocationAndGPSStates {}

// class LocationAndGPSLoadingState extends LocationAndGPSStates {}

// class LocationAndGPSNoGPSState extends LocationAndGPSStates {}

// class LocationAndGPSNoPermissionState extends LocationAndGPSStates {}

// class LocationAndGPSSuccessState extends LocationAndGPSStates {}
