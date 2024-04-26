import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String enName;
  final String? trName;
  final String? arName;
  final String imageUrl;

  const CategoryModel(
      {required this.arName,
      required this.enName,
      required this.id,
      required this.imageUrl,
      required this.trName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      arName: json['arName'],
      enName: json['enName'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      trName: json['trName'],
    );
  }

  @override
  List<Object?> get props => [id, enName, trName, arName, imageUrl];
}
