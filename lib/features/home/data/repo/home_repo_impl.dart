import 'package:dartz/dartz.dart';
import 'package:market_app_2/features/home/data/models/banners_model.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';
import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/branch_model.dart';
import 'home_repo.dart';

class HomeRepoImple implements HomeRepo {
  const HomeRepoImple(this._httpServiceInterface);
  final HttpServiceInterface _httpServiceInterface;

  @override
  Future<Either<HttpFailure, BranchModel?>> getBranch(String query) async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.nearBranches,
      query: query,
      fromJson: (decodedJson) => BranchModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, List<BannerModel>?>> getBanners() async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.bannersBase,
      fromJson: (decodedJson) => List<BannerModel>.from(
          decodedJson.map((e) => BannerModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, List<BranchCategoryModel>?>> getCategories(
      String branchId) async {
    return await _httpServiceInterface.get(
      url: '${EndPointConstants.branchBase}/$branchId/BranchCategory',
      fromJson: (decodedJson) => List<BranchCategoryModel>.from(
          decodedJson.map((e) => BranchCategoryModel.fromJson(e))),
    );
  }
}
