import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/home/data/models/category_model.dart';

class BranchCategoryModel extends Equatable {
  final int id;
  final String? branchId;
  final String? categoryId;
  final CategoryModel? category;
  final bool? isEnabled;

  const BranchCategoryModel({
    required this.id,
    this.branchId,
    this.categoryId,
    this.category,
    this.isEnabled,
  });

  factory BranchCategoryModel.fromJson(Map<String, dynamic> json) {
    return BranchCategoryModel(
      id: json['id'],
      branchId: json['branchId'],
      categoryId: json['categoryId'],
      category: json['category'] != null
          ? CategoryModel.fromJson(json['category'])
          : null,
      isEnabled: json['isEnabled'],
    );
  }

  @override
  List<Object?> get props => [id, branchId, categoryId, category, isEnabled];
}
