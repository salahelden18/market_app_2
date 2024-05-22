import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/constants/endpoint_constants.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/core/services/http_service_interface.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';
import 'package:market_app_2/features/search/data/repos/search_repo.dart';

class SearchRepoImpl extends SearchRepo {
  final HttpServiceInterface _httpServiceInterface;
  SearchRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, List<BranchProductModel>?>> getSearchResult(
      BuildContext context, String searchValue) {
    return _httpServiceInterface.get(
      url: EndPointConstants.search(
          context.read<BranchCubit>().state.branchModel!.id),
      fromJson: (decodedJson) => List<BranchProductModel>.from(
          decodedJson.map((e) => BranchProductModel.fromJson(e))),
      query: 's=$searchValue',
    );
  }
}
