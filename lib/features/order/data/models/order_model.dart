import 'package:equatable/equatable.dart';
import '../../../basket/data/models/basket_response_model.dart';
import '../../../address/data/models/address_model.dart';
import 'order_events.dart';
import 'order_status_model.dart';
import 'payment_method_model.dart';

class OrderModel extends Equatable {
  final String id;
  final int orderId;
  final double totalPrice;
  final double deliveryFees;
  final String createdAt;
  final PaymentMethodModel? paymentMethodModel;
  final OrderStatusModel? orderStatusModel;
  final BasketReponseModel? basketModel;
  final AddressModel? addressModel;
  final List<OrderEvent> orderEvents;
  final bool? loadCurrentActiveOrders;

  const OrderModel({
    required this.id,
    required this.orderId,
    required this.totalPrice,
    required this.deliveryFees,
    required this.createdAt,
    required this.orderStatusModel,
    required this.paymentMethodModel,
    required this.basketModel,
    required this.addressModel,
    required this.orderEvents,
    this.loadCurrentActiveOrders,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    print('Here in order model');
    return OrderModel(
      loadCurrentActiveOrders: json['loadCurrentActiveOrders'],
      id: json['id'],
      orderId: json['orderId'],
      totalPrice: double.tryParse(json['totalPrice'].toString()) ?? 0.0,
      deliveryFees: double.tryParse(json['deliveryFees'].toString()) ?? 0.0,
      createdAt: json['createdAt'],
      orderStatusModel: json['orderStatus'] != null
          ? OrderStatusModel.fromJson(json['orderStatus'])
          : null,
      paymentMethodModel: json['paymentMethod'] != null
          ? PaymentMethodModel.fromJson(json['paymentMethod'])
          : null,
      basketModel: json['basket'] != null
          ? BasketReponseModel.fromJson(json['basket'])
          : null,
      addressModel: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
      orderEvents: json['orderEvents'] != null
          ? List<OrderEvent>.from(
              json['orderEvents'].map(
                (e) => OrderEvent.fromJson(e),
              ),
            )
          : [],
    );
  }

  OrderModel copyWith({
    String? id,
    int? orderId,
    double? totalPrice,
    double? deliveryFees,
    String? createdAt,
    PaymentMethodModel? paymentMethodModel,
    OrderStatusModel? orderStatusModel,
    BasketReponseModel? basketModel,
    AddressModel? addressModel,
    List<OrderEvent>? orderEvents,
    bool? loadCurrentActiveOrders,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      totalPrice: totalPrice ?? this.totalPrice,
      deliveryFees: deliveryFees ?? this.deliveryFees,
      createdAt: createdAt ?? this.createdAt,
      paymentMethodModel: paymentMethodModel ?? this.paymentMethodModel,
      orderStatusModel: orderStatusModel ?? this.orderStatusModel,
      basketModel: basketModel ?? this.basketModel,
      addressModel: addressModel ?? this.addressModel,
      orderEvents: orderEvents ?? this.orderEvents,
      loadCurrentActiveOrders:
          loadCurrentActiveOrders ?? this.loadCurrentActiveOrders,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        totalPrice,
        deliveryFees,
        createdAt,
        orderStatusModel,
        paymentMethodModel,
        basketModel,
        addressModel,
        orderEvents,
        loadCurrentActiveOrders,
      ];
}
