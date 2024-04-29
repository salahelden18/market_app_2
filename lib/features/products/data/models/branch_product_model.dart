import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/products/data/models/product_model.dart';

class BranchProductModel extends Equatable {
  final int id;
  final int stock;
  final double price;
  final double? discountValue;
  final int? discountTypes;
  final ProductModel? product;

  const BranchProductModel({
    required this.id,
    required this.stock,
    required this.price,
    required this.discountValue,
    required this.discountTypes,
    required this.product,
  });

  factory BranchProductModel.fromJson(Map<String, dynamic> json) {
    print('here in branch produuct model');

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
    );
  }

  @override
  List<Object?> get props =>
      [id, stock, price, discountValue, discountTypes, product];
}
