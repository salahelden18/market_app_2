import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/products/data/models/product_model.dart';

class FavoriteModel extends Equatable {
  final String id;
  final String addedAt;
  final ProductModel product;

  const FavoriteModel({
    required this.addedAt,
    required this.id,
    required this.product,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      addedAt: json['addedAt'],
      id: json['id'],
      product: ProductModel.fromJson(json['product']),
    );
  }

  @override
  List<Object?> get props => [id, addedAt, product];
}
