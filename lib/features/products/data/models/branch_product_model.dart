import 'package:equatable/equatable.dart';
import '../../../favorite/data/models/branch_sub_category_model.dart';
import 'product_model.dart';

class BranchProductModel extends Equatable {
  final int id;
  final int stock;
  final double price;
  final double? discountValue;
  final int? discountTypes;
  final ProductModel? product;
  final BranchSubCategoryModel? branchSubCategoryModel;

  const BranchProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.discountValue,
    required this.discountTypes,
    required this.product,
    this.branchSubCategoryModel,
  });

  factory BranchProductModel.fromJson(Map<String, dynamic> json) {
    return BranchProductModel(
      id: json['id'],
      stock: json['stock'],
      price: double.tryParse(json['price'].toString()) ?? 0,
      discountValue:
          double.tryParse(json['discountValue'].toString()) ?? 0.toDouble(),
      discountTypes: json['discountTypes'],
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'])
          : null,
      branchSubCategoryModel: json['branchSubCategory'] != null
          ? BranchSubCategoryModel.fromJson(json['branchSubCategory'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        stock,
        price,
        discountValue,
        discountTypes,
        product,
        branchSubCategoryModel
      ];
}
