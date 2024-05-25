import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';
import '../../../data/repo/home_repo.dart';
import 'categories_states.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit(this._homeRepo) : super(CategoriesInitialState());
  final HomeRepo _homeRepo;

  Future getCategories(String branchId) async {
    emit(CategoriesLoadingState());

    var result = await _homeRepo.getCategories(branchId);

    result.fold((l) => emit(CategoriesFailureState(l.message)), (r) {
      List<BranchCategoryModel> categories = [];
      for (var n in r!) {
        if (n.isEnabled!) {
          categories.add(n);
        }
      }
      emit(CategoriesSuccessState(categories));
    });
  }
}
