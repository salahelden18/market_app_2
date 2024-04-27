import 'package:equatable/equatable.dart';

class AddressCommonModel extends Equatable {
  final String id;
  final String enName;
  final String? arName;
  final String? trName;
  final String createdAt;
  final String? countryIsoCode;
  final String? countryCode;

  const AddressCommonModel({
    required this.arName,
    required this.countryCode,
    required this.countryIsoCode,
    required this.createdAt,
    required this.enName,
    required this.id,
    required this.trName,
  });

  factory AddressCommonModel.fromJson(Map<String, dynamic> json) {
    return AddressCommonModel(
      arName: json['arName'],
      countryCode: json['countryCode'],
      countryIsoCode: json['countryIsoCode'],
      createdAt: json['createdAt'],
      enName: json['enName'],
      id: json['id'],
      trName: json['trName'],
    );
  }

  @override
  List<Object?> get props =>
      [id, enName, trName, arName, countryCode, countryIsoCode, createdAt];
}
