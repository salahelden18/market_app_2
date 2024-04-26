import 'package:geocoding/geocoding.dart';
import '../models/current_location_model.dart';
import 'location_service_interface.dart';

import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';

class LocationService implements LocationServiceInterface {
  @override
  Future<bool> checkPermissions() async {
    PermissionStatus permission;

    permission = await Permission.locationWhenInUse.status;

    if (permission.isDenied) {
      try {
        permission = await Permission.locationWhenInUse.request();
      } catch (_) {
        return false;
      }
    }

    if (permission.isDenied || permission.isPermanentlyDenied) {
      return false;
    }

    return true;
  }

  @override
  Future<CurrentLocationModel> getCurrentUserLocation() async {
    geo.LocationAccuracy locationAccuracy = geo.LocationAccuracy.low;

    geo.Position? position;
    List<Placemark?> placemarks;
    Placemark? placemark;

    position = await geo.Geolocator.getCurrentPosition(
      desiredAccuracy: locationAccuracy,
      timeLimit: const Duration(seconds: 10),
    );

    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    if (placemarks.isNotEmpty) {
      placemark = placemarks.first;
    }

    return CurrentLocationModel(
      country: placemark?.country ?? '',
      city: placemark?.administrativeArea ?? '',
      street: placemark?.thoroughfare ?? '',
      area: placemark?.subLocality ?? '',
      building: placemark?.subThoroughfare ?? '',
      neighborhood: placemark?.subAdministrativeArea ?? '',
      countryIsoCode: placemark?.isoCountryCode ?? '',
      lat: position.latitude,
      lng: position.longitude,
    );
  }

  @override
  Future<bool> isServiceEnabled() async {
    bool isServiceEnabled = await geo.Geolocator.isLocationServiceEnabled();

    return isServiceEnabled;
  }
}

// import 'dart:async';

// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart' as goe;
// import 'package:market_app_2/core/services/location_service_interface.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../models/current_location_address_model.dart';

// class LocationService implements LocationServiceInterface {
//   @override
//   Future<bool> isServiceEnabled() async {
//     bool isServiceEnabled = await goe.Geolocator.isLocationServiceEnabled();

//     return isServiceEnabled;
//   }

//   @override
//   Future<bool> checkPermissions() async {
//     PermissionStatus permission;

//     permission = await Permission.locationWhenInUse.status;

//     if (permission.isDenied) {
//       try {
//         permission = await Permission.locationWhenInUse.request();
//       } catch (_) {
//         return false;
//       }
//     }

//     if (permission.isDenied || permission.isPermanentlyDenied) {
//       return false;
//     }

//     return true;
//   }

//   @override
//   Future<CurrentLocationAddressModel> getCurrentUserLocation() async {
//     goe.LocationAccuracy locationAccuracy = goe.LocationAccuracy.low;

//     goe.Position? position;
//     List<Placemark?> placemarks;
//     Placemark? placemark;

//     position = await goe.Geolocator.getCurrentPosition(
//       desiredAccuracy: locationAccuracy,
//       timeLimit: const Duration(seconds: 10),
//     );

//     placemarks =
//         await placemarkFromCoordinates(position.latitude, position.longitude);

//     if (placemarks.isNotEmpty) {
//       placemark = placemarks.first;
//     }

//     return CurrentLocationAddressModel(
//       country: placemark?.country ?? '',
//       city: placemark?.administrativeArea ?? '',
//       street: placemark?.thoroughfare ?? '',
//       area: placemark?.subLocality ?? '',
//       building: placemark?.subThoroughfare ?? '',
//       neighborhood: placemark?.subAdministrativeArea ?? '',
//       countryIsoCode: placemark?.isoCountryCode ?? '',
//       lat: position.latitude,
//       lng: position.longitude,
//     );
//   }
// }
