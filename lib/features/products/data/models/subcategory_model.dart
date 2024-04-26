import 'package:equatable/equatable.dart';

class SubCategoryModel extends Equatable {
  final String id;
  final String enName;
  final String? trName;
  final String? arName;
  final String categoryId;

  const SubCategoryModel({
    required this.id,
    required this.enName,
    required this.trName,
    required this.arName,
    required this.categoryId,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'],
      enName: json['enName'],
      trName: json['trName'],
      arName: json['arName'],
      categoryId: json['categoryId'],
    );
  }

  @override
  List<Object?> get props => [id, enName, trName, arName, categoryId];
}
