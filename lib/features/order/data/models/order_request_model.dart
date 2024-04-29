import 'package:equatable/equatable.dart';

class OrderRequestModel extends Equatable {
  final String paymentMethodId;
  final String basketId;
  final String addressId;

  const OrderRequestModel({
    required this.addressId,
    required this.basketId,
    required this.paymentMethodId,
  });

  Map<String, dynamic> toJson() {
    return {
      "paymentMethodId": paymentMethodId,
      "basketId": basketId,
      "addressId": addressId,
    };
  }

  @override
  List<Object?> get props => [paymentMethodId, basketId, addressId];
}
