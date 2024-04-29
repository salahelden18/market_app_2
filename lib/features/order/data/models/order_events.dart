import 'package:equatable/equatable.dart';

import 'order_status_model.dart';

class OrderEvent extends Equatable {
  final int id;
  final String addedAt;
  final OrderStatusModel? orderStatusModel;

  const OrderEvent({
    required this.addedAt,
    required this.id,
    required this.orderStatusModel,
  });

  factory OrderEvent.fromJson(Map<String, dynamic> json) {
    return OrderEvent(
      addedAt: json['addedAt'],
      orderStatusModel: json['orderStatus'] != null
          ? OrderStatusModel.fromJson(json['orderStatus'])
          : null,
      id: json['id'],
    );
  }

  @override
  List<Object?> get props => [id, addedAt, orderStatusModel];
}
