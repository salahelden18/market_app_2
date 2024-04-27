import 'package:equatable/equatable.dart';

class AddressRequestModel extends Equatable {
  final String fullAddress;
  final String? additionalInfo;
  final String apartment;
  final String floor;
  final int flatNumber;
  final String? countryId;
  final String? cityId;
  final String? districtId;
  final String? subDistrictId;
  final double? lat;
  final double? lng;

  const AddressRequestModel({
    required this.fullAddress,
    required this.apartment,
    required this.floor,
    required this.flatNumber,
    this.lat,
    this.lng,
    this.additionalInfo,
    this.cityId,
    this.countryId,
    this.districtId,
    this.subDistrictId,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullAddress': fullAddress,
      'lat': lat,
      'lng': lng,
      'additionalInfo': additionalInfo,
      'apartment': apartment,
      'floor': floor,
      'flatNumber': flatNumber,
      'countryId': countryId,
      'cityId': cityId,
      'districtId': districtId,
      'subDistrictId': subDistrictId,
    }..removeWhere((key, value) => value == null);
  }

  @override
  List<Object?> get props => [
        fullAddress,
        lat,
        lng,
        additionalInfo,
        flatNumber,
        floor,
        apartment,
        countryId,
        cityId,
        districtId,
        subDistrictId
      ];
}
