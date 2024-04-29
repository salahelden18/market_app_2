import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/address/data/models/address_common_model.dart';

class AddressModel extends Equatable {
  final String id;
  final String? fullAddress;
  final double? lat;
  final double? lng;
  final String? additionalInfo;
  final String? apartment;
  final String? floor;
  final int? flatNumber;
  final String? countryId;
  final String? cityId;
  final String? districtId;
  final String? subDistrictId;
  final AddressCommonModel? country;
  final AddressCommonModel? city;
  final AddressCommonModel? district;
  final AddressCommonModel? subDistrict;

  const AddressModel({
    required this.id,
    required this.fullAddress,
    required this.lat,
    required this.lng,
    required this.additionalInfo,
    required this.apartment,
    required this.floor,
    required this.flatNumber,
    required this.countryId,
    required this.cityId,
    required this.districtId,
    required this.subDistrictId,
    required this.district,
    required this.city,
    required this.country,
    required this.subDistrict,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    print('Here in address model');
    return AddressModel(
      id: json['id'],
      fullAddress: json['fullAddress'],
      lat: double.tryParse(json['lat'].toString()) ?? 0,
      lng: double.tryParse(json['lng'].toString()) ?? 0,
      additionalInfo: json['additionalInfo'],
      apartment: json['apartment'],
      floor: json['apartment'],
      flatNumber: json['flatNumber'],
      countryId: json['countryId'],
      cityId: json['cityId'],
      districtId: json['districtId'],
      subDistrictId: json['subDistrictId'],
      country: json['country'] != null
          ? AddressCommonModel.fromJson(json['country'])
          : null,
      city: json['city'] != null
          ? AddressCommonModel.fromJson(json['city'])
          : null,
      district: json['district'] != null
          ? AddressCommonModel.fromJson(json['district'])
          : null,
      subDistrict: json['subDistrict'] != null
          ? AddressCommonModel.fromJson(json['subDistrict'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fullAddress'] = fullAddress;
    data['lat'] = lat;
    data['lng'] = lng;
    data['additionalInfo'] = additionalInfo;
    data['apartment'] = apartment;
    data['floor'] = floor;
    data['flatNumber'] = flatNumber;
    data['countryId'] = countryId;
    data['cityId'] = cityId;
    data['districtId'] = districtId;
    data['subDistrictId'] = subDistrictId;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        fullAddress,
        lat,
        lng,
        additionalInfo,
        apartment,
        flatNumber,
        floor,
        countryId,
        cityId,
        districtId,
        subDistrictId,
        country,
        city,
        district,
        subDistrict,
      ];
}
