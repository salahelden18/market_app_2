import 'package:dartz/dartz.dart';
import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/basket_request_model.dart';
import '../models/basket_response_model.dart';
import 'basket_repo.dart';

class BasketRepoImpl implements BasketRepo {
  final HttpServiceInterface _httpServiceInterface;

  BasketRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, BasketReponseModel?>> addProductTobasket(
      BasketRequestModel basketRequestModel) async {
    return await _httpServiceInterface.post(
      url: EndPointConstants.basketBase,
      fromJson: (decoedjson) => BasketReponseModel.fromJson(decoedjson),
      body: basketRequestModel.toJson(),
    );
  }

  @override
  Future<Either<HttpFailure, BasketReponseModel?>> clearBasket(
      String basketId) async {
    return await _httpServiceInterface.delete(
      url: '${EndPointConstants.basketBase}/$basketId',
      fromJson: (decodedJson) => null,
    );
  }

  @override
  Future<Either<HttpFailure, BasketReponseModel?>> decreaseQuantity(
      int itemId) async {
    return await _httpServiceInterface.patch(
      url: '${EndPointConstants.basketBase}/decrease-quantity/$itemId',
      fromJson: (decodedJson) => BasketReponseModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, BasketReponseModel?>> deleteItem(
      int itemId) async {
    return await _httpServiceInterface.patch(
      url: '${EndPointConstants.basketBase}/delete-item/$itemId',
      fromJson: (decodedJson) => BasketReponseModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, BasketReponseModel?>> getBasket(
      String branchId) async {
    return await _httpServiceInterface.get(
      url: '${EndPointConstants.basketBase}/$branchId',
      fromJson: (decodedJson) => BasketReponseModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, BasketReponseModel?>> increaseQuantity(
      int itemId) async {
    return await _httpServiceInterface.patch(
      url: '${EndPointConstants.basketBase}/increase-quantity/$itemId',
      fromJson: (decodedJson) => BasketReponseModel.fromJson(decodedJson),
    );
  }
}
