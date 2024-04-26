import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/basket/data/models/basket_request_model.dart';
import 'package:market_app_2/features/basket/data/models/basket_response_model.dart';

abstract class BasketRepo {
  Future<Either<HttpFailure, BasketReponseModel?>> addProductTobasket(
      BasketRequestModel basketRequestModel);
  Future<Either<HttpFailure, BasketReponseModel?>> getBasket(String branchId);
  Future<Either<HttpFailure, BasketReponseModel?>> increaseQuantity(int itemId);
  Future<Either<HttpFailure, BasketReponseModel?>> decreaseQuantity(int itemId);
  Future<Either<HttpFailure, BasketReponseModel?>> deleteItem(int itemId);
  Future<Either<HttpFailure, BasketReponseModel?>> clearBasket(String basketId);
}
