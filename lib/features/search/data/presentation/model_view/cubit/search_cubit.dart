import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';
import 'package:market_app_2/features/search/data/repos/search_repo_impl.dart';
import 'package:market_app_2/service_locator.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  final SearchRepoImpl _searchRepoImpl = SearchRepoImpl(sl());

// Get search results
  Future<void> search({
    required BuildContext context,
    required String searchValue,
  }) async {
    emit(SearchLoadingState());

    // The result of the search
    var result = await _searchRepoImpl.getSearchResult(context, searchValue);

    result.fold((l) => emit(SearchErrorState(l.message)),
        (r) => emit(SearchSuccessState(r!)));
  }
}
