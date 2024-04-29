import 'package:equatable/equatable.dart';

class BranchModel extends Equatable {
  final String id;
  final String? enName;
  final String? arName;
  final String? trName;
  final double? lat;
  final double? lng;
  final String? enDetailedAddress;
  final String? arDetailedAddress;
  final String? trDetailedAddress;
  final double? deliveryFees;
  final int? deliveryTime;
  final int? minimumOrderValue;
  final int? maximumCoverAreaInKM;
  final bool? isOutsideDelivery;

  const BranchModel(
      {required this.id,
      this.enName,
      this.arName,
      this.trName,
      this.lat,
      this.lng,
      this.enDetailedAddress,
      this.arDetailedAddress,
      this.trDetailedAddress,
      this.deliveryFees,
      this.deliveryTime,
      this.minimumOrderValue,
      this.maximumCoverAreaInKM,
      this.isOutsideDelivery});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      enName: json['enName'],
      arName: json['arName'],
      trName: json['trName'],
      lat: json['lat'],
      lng: json['lng'],
      enDetailedAddress: json['enDetailedAddress'],
      arDetailedAddress: json['arDetailedAddress'],
      trDetailedAddress: json['trDetailedAddress'],
      deliveryFees: double.tryParse(json['deliveryFees'].toString()),
      deliveryTime: json['deliveryTime'],
      minimumOrderValue: json['minimumOrderValue'],
      maximumCoverAreaInKM: json['maximumCoverAreaInKM'],
      isOutsideDelivery: json['isOutsideDelivery'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enName'] = enName;
    data['arName'] = arName;
    data['trName'] = trName;
    data['lat'] = lat;
    data['lng'] = lng;
    data['enDetailedAddress'] = enDetailedAddress;
    data['arDetailedAddress'] = arDetailedAddress;
    data['trDetailedAddress'] = trDetailedAddress;
    data['deliveryFees'] = deliveryFees;
    data['deliveryTime'] = deliveryTime;
    data['minimumOrderValue'] = minimumOrderValue;
    data['maximumCoverAreaInKM'] = maximumCoverAreaInKM;
    data['isOutsideDelivery'] = isOutsideDelivery;
    return data;
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
      ];
}
