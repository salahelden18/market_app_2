import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';
import 'package:market_app_2/features/products/data/models/custome_product_model.dart';
import 'package:market_app_2/features/products/data/repos/product_repo.dart';
import 'products_states.dart';

class ProductsCubit extends Cubit<ProductStates> {
  ProductsCubit(this._productsRepo) : super(const ProductStates());
  final ProductsRepo _productsRepo;

  void init(List<BranchCategoryModel> branchCategories) {
    List<CustomProductModel> data = [];

    data = branchCategories.map((e) {
      return CustomProductModel(
        branchCategoryModel: e,
        isLoadedBefore: false,
        productsReponseModel: const [],
      );
    }).toList();

    emit(ProductStates(products: data));
  }

  Future loadData(BranchCategoryModel branchCategoryModel) async {}

  Future getData(String branchId, int branchCategoryId) async {
    var result =
        await _productsRepo.getbrachProducts(branchId, branchCategoryId);

    result.fold(
      (l) => null,
      (r) {
        var updatedItem = state.products.firstWhere(
            (element) => element.branchCategoryModel.id == branchCategoryId);

        // Update the item with the new data
        updatedItem = updatedItem.copyWith(
          isLoadedBefore: true,
          productsReponseModel: r,
        );

        // Update the state with the updated item
        var updatedList = state.products.map((item) {
          if (item.branchCategoryModel.id == branchCategoryId) {
            return updatedItem;
          } else {
            return item;
          }
        }).toList();

        emit(ProductStates(products: updatedList));
      },
    );
  }

  Future getRecommendedProducts(int branchCategoryId) async {
    var result = await _productsRepo.getRecommendedProducts(branchCategoryId);

    result.fold(
      (l) => null,
      (r) {
        emit(ProductStates(recommendedProduct: r!));
      },
    );
  }
}
