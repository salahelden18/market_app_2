import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/products/data/models/products_response_model.dart';

abstract class ProductsRepo {
  Future<Either<HttpFailure, List<ProductsReponseModel>?>> getbrachProducts(
      String branchId, int branchCategoryId);
}
