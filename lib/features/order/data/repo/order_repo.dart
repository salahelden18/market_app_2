import 'package:dartz/dartz.dart';
import '../models/order_model.dart';
import '../models/order_request_model.dart';
import '../../../../core/error/http_failure.dart';
import '../models/payment_method_model.dart';

abstract class OrderRepo {
  Future<Either<HttpFailure, List<PaymentMethodModel>?>> getPaymentMethods(
      String branchId);

  Future<Either<HttpFailure, OrderModel?>> order(
      OrderRequestModel orderRequestModel);
}
