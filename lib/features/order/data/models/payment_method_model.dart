import 'package:equatable/equatable.dart';

class PaymentMethodModel extends Equatable {
  final String id;
  final String enName;
  final String trName;
  final String arName;
  final String createdAt;

  const PaymentMethodModel({
    required this.arName,
    required this.createdAt,
    required this.enName,
    required this.id,
    required this.trName,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      arName: json['arName'],
      createdAt: json['createdAt'],
      enName: json['enName'],
      id: json['id'],
      trName: json['trName'],
    );
  }

  @override
  List<Object?> get props => [id, enName, trName, arName, createdAt];
}
