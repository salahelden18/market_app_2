import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';

abstract class SearchRepo {
  Future<Either<HttpFailure, List<BranchProductModel>?>> getSearchResult(
      BuildContext context, String searchValue);
}
