import 'package:equatable/equatable.dart';
import 'basket_product_model.dart';

class BasketReponseModel extends Equatable {
  final String id;
  final String? customerId;
  final String? userId;
  final double totalPrice;
  final List<BasketProductModel> basketProducts;

  const BasketReponseModel({
    required this.customerId,
    required this.id,
    required this.totalPrice,
    required this.userId,
    required this.basketProducts,
  });

  factory BasketReponseModel.fromJson(Map<String, dynamic> json) {
    return BasketReponseModel(
      customerId: json['customerid'],
      id: json['id'],
      totalPrice: double.tryParse(json['totalPrice'].toString()) ?? 0,
      userId: json['userId'],
      basketProducts: json['basketProducts'] != null
          ? List<BasketProductModel>.from(
              json['basketProducts'].map((e) => BasketProductModel.fromJson(e)),
            )
          : [],
    );
  }

  @override
  List<Object?> get props =>
      [id, customerId, userId, totalPrice, basketProducts];
}
