import 'package:market_app_2/core/models/current_location_model.dart';

abstract class LocationServiceInterface {
  Future<bool> isServiceEnabled();

  Future<bool> checkPermissions();

  Future<CurrentLocationModel?> getCurrentUserLocation();
}
