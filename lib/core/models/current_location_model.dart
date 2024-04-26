import 'package:equatable/equatable.dart';

class CurrentLocationModel extends Equatable {
  final String country;
  final String city;
  final String area;
  final String street;
  final String building;
  final String neighborhood;
  final String countryIsoCode;
  final double lat;
  final double lng;

  const CurrentLocationModel({
    required this.country,
    required this.city,
    required this.area,
    required this.street,
    required this.building,
    required this.neighborhood,
    required this.countryIsoCode,
    required this.lat,
    required this.lng,
  });

  @override
  List<Object> get props => [
        country,
        city,
        area,
        street,
        building,
        neighborhood,
        countryIsoCode,
        lat,
        lng
      ];
}
