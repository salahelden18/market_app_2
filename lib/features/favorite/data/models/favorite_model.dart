import 'package:equatable/equatable.dart';
import '../../../products/data/models/branch_product_model.dart';

class FavoriteModel extends Equatable {
  final String id;
  final String addedAt;
  final BranchProductModel branchProduct;

  const FavoriteModel({
    required this.addedAt,
    required this.id,
    required this.branchProduct,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      addedAt: json['addedAt'],
      id: json['id'],
      branchProduct: BranchProductModel.fromJson(json['branchProduct']),
    );
  }

  @override
  List<Object?> get props => [id, addedAt, branchProduct];
}
