import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/constants/endpoint_constants.dart';
import 'package:market_app_2/features/order/data/models/order_model.dart';
import 'package:market_app_2/features/order/data/models/order_request_model.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/order_status_model.dart';
import '../models/payment_method_model.dart';

import 'order_repo.dart';

class OrderRepoImple implements OrderRepo {
  OrderRepoImple(this._httpServiceInterface);

  final HttpServiceInterface _httpServiceInterface;

  @override
  Future<Either<HttpFailure, List<PaymentMethodModel>?>> getPaymentMethods(
      String branchId) async {
    return await _httpServiceInterface.get(
      url: '${EndPointConstants.paymentBase}/$branchId',
      fromJson: (decodedJson) => List<PaymentMethodModel>.from(
          decodedJson.map((e) => PaymentMethodModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, OrderModel?>> order(
      OrderRequestModel orderRequestModel) async {
    return await _httpServiceInterface.post(
      url: EndPointConstants.orderBase,
      fromJson: (decodedJson) => OrderModel.fromJson(decodedJson),
      body: orderRequestModel.toJson(),
    );
  }

  @override
  Future<Either<HttpFailure, List<OrderModel>?>> getOrdersList(
      String query) async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.orderBase,
      query: query,
      fromJson: (decodedJson) => List<OrderModel>.from(
        decodedJson.map((e) => OrderModel.fromJson(e)),
      ),
    );
  }

  @override
  Future<Either<HttpFailure, OrderModel?>> getOrderDetails(
      String orderId) async {
    return await _httpServiceInterface.get(
      url: '${EndPointConstants.orderBase}/$orderId',
      fromJson: (decodedJson) => OrderModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, OrderStatusModel?>> cancelOrder(
      String orderId) async {
    return await _httpServiceInterface.patch(
      url: '${EndPointConstants.orderBase}/cancel-order/$orderId',
      fromJson: (decodedJson) => OrderStatusModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, List<OrderModel>?>>
      getCurrentActiveOrders() async {
    return await _httpServiceInterface.get(
        url: '${EndPointConstants.orderBase}/active-orders',
        fromJson: (decodedJson) => List<OrderModel>.from(
            decodedJson.map((e) => OrderModel.fromJson(e))));
  }
}
