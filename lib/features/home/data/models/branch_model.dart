import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String id;
  final String enName;
  final String? arName;
  final String? trName;
  final double lat;
  final double lng;
  final String? enDetailedAddress;
  final String? arDetailedAddress;
  final String? trDetailedAddress;
  final double? deliveryFees;
  final int? deliveryTime;
  final double? minimumOrderValue;
  final double? maximumCoverAreaInKM;
  final bool isOutsideDelivery;
  final String? currency;
  final String? currencySymbol;

  const BranchModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.trName,
    required this.lat,
    required this.lng,
    required this.enDetailedAddress,
    required this.arDetailedAddress,
    required this.trDetailedAddress,
    required this.deliveryFees,
    required this.deliveryTime,
    required this.minimumOrderValue,
    required this.maximumCoverAreaInKM,
    required this.isOutsideDelivery,
    required this.currency,
    required this.currencySymbol,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      enName: json['enName'],
      arName: json['arName'],
      trName: json['trName'],
      lat: double.tryParse(json['lat'].toString()) ?? 0,
      lng: double.tryParse(json['lng'].toString()) ?? 0,
      enDetailedAddress: json['enDetailedAddress'],
      arDetailedAddress: json['arDetailedAddress'],
      trDetailedAddress: json['trDetailedAddress'],
      deliveryFees: double.tryParse(json['deliveryFees'].toString()) ?? 0,
      deliveryTime: int.tryParse(json['deliveryTime'].toString()) ?? 0,
      minimumOrderValue: double.tryParse(json['minimumOrderValue'].toString()),
      maximumCoverAreaInKM:
          double.tryParse(json['maximumCoverAreaInKM'].toString()),
      isOutsideDelivery: json['isOutsideDelivery'],
      currency: json['currency'],
      currencySymbol: json['currencySymbol'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        enName,
        arName,
        trName,
        lat,
        lng,
        enDetailedAddress,
        arDetailedAddress,
        trDetailedAddress,
        deliveryFees,
        deliveryTime,
        minimumOrderValue,
        maximumCoverAreaInKM,
        isOutsideDelivery,
        currency,
        currencySymbol,
      ];
}
