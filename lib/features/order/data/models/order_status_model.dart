import 'package:equatable/equatable.dart';

class OrderStatusModel extends Equatable {
  final String id;
  final String? enName;
  final String? trName;
  final String? arName;
  final String? enDesc;
  final String? trDesc;
  final String? arDesc;
  final String createdAt;

  const OrderStatusModel({
    required this.id,
    required this.enName,
    required this.trName,
    required this.arName,
    required this.enDesc,
    required this.arDesc,
    required this.trDesc,
    required this.createdAt,
  });

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderStatusModel(
      id: json['id'],
      enName: json['enName'],
      trName: json['trName'],
      arName: json['arName'],
      enDesc: json['enDesc'],
      arDesc: json['arDesc'],
      trDesc: json['trDesc'],
      createdAt: json['createdAt'],
    );
  }

  @override
  List<Object?> get props =>
      [id, enName, trName, arName, enDesc, arDesc, trDesc, createdAt];
}
