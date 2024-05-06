import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/home/data/models/22.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';
import 'package:market_app_2/features/products/data/models/products_response_model.dart';

class CustomProductModel extends Equatable {
  final BranchCategoryModel branchCategoryModel;
  final List<ProductsReponseModel> productsReponseModel;
  final bool isLoadedBefore;

  const CustomProductModel({
    required this.branchCategoryModel,
    required this.isLoadedBefore,
    required this.productsReponseModel,
  });

  CustomProductModel copyWith({
    BranchCategoryModel? branchCategoryModel,
    List<ProductsReponseModel>? productsReponseModel,
    bool? isLoadedBefore,
  }) {
    return CustomProductModel(
      branchCategoryModel: branchCategoryModel ?? this.branchCategoryModel,
      isLoadedBefore: isLoadedBefore ?? this.isLoadedBefore,
      productsReponseModel: productsReponseModel ?? this.productsReponseModel,
    );
  }

  @override
  List<Object?> get props =>
      [branchCategoryModel, productsReponseModel, isLoadedBefore];
}
