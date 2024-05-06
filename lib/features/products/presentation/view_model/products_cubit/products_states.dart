import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';
import '../../../data/models/custome_product_model.dart';

class ProductStates extends Equatable {
  final List<CustomProductModel> products;
  final List<BranchProductModel> recommendedProduct;

  const ProductStates({
    this.products = const [],
    this.recommendedProduct = const [],
  });

  @override
  List<Object?> get props => [products];
}
