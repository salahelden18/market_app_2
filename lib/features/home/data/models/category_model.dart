import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String? enName;
  final String? trName;
  final String? arName;
  final String? imageUrl;

  const CategoryModel({
    required this.id,
    this.enName,
    this.trName,
    this.arName,
    this.imageUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      enName: json['enName'],
      trName: json['trName'],
      arName: json['arName'],
      imageUrl: json['imageUrl'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        enName,
        trName,
        arName,
        imageUrl,
      ];
}
