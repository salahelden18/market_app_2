import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/products/data/models/subcategory_model.dart';

import 'branch_product_model.dart';

class ProductsReponseModel extends Equatable {
  final int id;
  final bool isEnabled;
  final SubCategoryModel subCategoryModel;
  final List<BranchProductModel> branchProducts;

  const ProductsReponseModel({
    required this.branchProducts,
    required this.id,
    required this.isEnabled,
    required this.subCategoryModel,
  });

  factory ProductsReponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsReponseModel(
      branchProducts: List<BranchProductModel>.from(
        json['branchProducts'].map((e) => BranchProductModel.fromJson(e)),
      ),
      id: json['id'],
      isEnabled: json['isEnabled'],
      subCategoryModel: SubCategoryModel.fromJson(json['subCategory']),
    );
  }

  @override
  List<Object?> get props => [id, isEnabled, subCategoryModel, branchProducts];
}
