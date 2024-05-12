import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/home/data/models/banners_model.dart';
import 'package:market_app_2/features/home/data/models/branch_model.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';

abstract class HomeRepo {
  Future<Either<HttpFailure, BranchModel?>> getBranch(String query);
  Future<Either<HttpFailure, List<BannerModel>?>> getBanners();
  Future<Either<HttpFailure, List<BranchCategoryModel>?>> getCategories(
      String branchId);
}
