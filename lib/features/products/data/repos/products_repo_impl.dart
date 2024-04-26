import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/constants/endpoint_constants.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/core/services/http_service_interface.dart';
import 'package:market_app_2/features/products/data/models/products_response_model.dart';
import 'package:market_app_2/features/products/data/repos/product_repo.dart';

class ProductsRepoImpl implements ProductsRepo {
  final HttpServiceInterface _httpServiceInterface;

  const ProductsRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, List<ProductsReponseModel>?>> getbrachProducts(
      String branchId, int branchCategoryId) async {
    return await _httpServiceInterface.get(
      url:
          '${EndPointConstants.branchBase}/$branchId/BranchCategory/$branchCategoryId/branch-products',
      fromJson: (decodedJson) => List<ProductsReponseModel>.from(
        decodedJson.map((e) => ProductsReponseModel.fromJson(e)),
      ),
    );
  }
}
