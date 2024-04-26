import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String enName;
  final String? arName;
  final String? trName;
  final String? enDescription;
  final String? trDescription;
  final String? arDescription;
  final String createdAt;
  final String? manufacturer;
  final String? updatedAt;
  final String? subCategoryId;
  final List<String> images;

  const ProductModel({
    required this.id,
    required this.enName,
    required this.arName,
    required this.trName,
    required this.enDescription,
    required this.trDescription,
    required this.arDescription,
    required this.createdAt,
    this.manufacturer,
    this.updatedAt,
    this.subCategoryId,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      enName: json['enName'],
      arName: json['arName'],
      trName: json['trName'],
      enDescription: json['enDescription'],
      trDescription: json['trDescription'],
      arDescription: json['arDescription'],
      createdAt: json['createdAt'],
      manufacturer: json['manufacturer'],
      updatedAt: json['updatedAt'],
      subCategoryId: json['subCategoryId'],
      images: List<String>.from(json['images']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        enName,
        arName,
        trName,
        enDescription,
        trDescription,
        arDescription,
        createdAt,
        manufacturer,
        updatedAt,
        subCategoryId,
        images,
      ];

  ProductModel copyWith({
    String? id,
    String? enName,
    String? arName,
    String? trName,
    String? enDescription,
    String? trDescription,
    String? arDescription,
    String? createdAt,
    String? manufacturer,
    String? updatedAt,
    String? subCategoryId,
    List<String>? images,
  }) {
    return ProductModel(
      id: id ?? this.id,
      enName: enName ?? this.enName,
      arName: arName ?? this.arName,
      trName: trName ?? this.trName,
      enDescription: enDescription ?? this.enDescription,
      trDescription: trDescription ?? this.trDescription,
      arDescription: arDescription ?? this.arDescription,
      createdAt: createdAt ?? this.createdAt,
      manufacturer: manufacturer ?? this.manufacturer,
      updatedAt: updatedAt ?? this.updatedAt,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      images: images ?? this.images,
    );
  }
}
