import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/home/data/models/category_model.dart';

class BranchCategoryModel extends Equatable {
  final int id;
  final String branchId;
  final String categoryId;
  final CategoryModel category;

  const BranchCategoryModel({
    required this.branchId,
    required this.category,
    required this.categoryId,
    required this.id,
  });

  factory BranchCategoryModel.fromJson(Map<String, dynamic> json) {
    return BranchCategoryModel(
      branchId: json['branchId'],
      category: CategoryModel.fromJson(json['category']),
      categoryId: json['categoryId'],
      id: json['id'],
    );
  }

  @override
  List<Object?> get props => [id, branchId, category, categoryId];
}
