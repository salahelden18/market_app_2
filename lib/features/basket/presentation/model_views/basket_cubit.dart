import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../data/models/basket_product_model.dart';
import '../../data/models/basket_request_model.dart';
import '../../data/repo/basket_repo.dart';
import 'basket_states.dart';

class BasketCubit extends Cubit<BasketStates> {
  BasketCubit(this._basketRepo) : super(const BasketStates());

  final BasketRepo _basketRepo;

  Future getBasket(String branchId) async {
    emit(state.copyWith(isFirstLoading: true));

    var result = await _basketRepo.getBasket(branchId);

    result.fold((l) {
      emit(state.copyWith(isFirstLoading: false));
    }, (r) {
      // emit(state.copyWith(isFirstLoading: false, basket: r));
      emit(BasketStates(basket: r, isFirstLoading: false));
    });
  }

  Future addToBasket(BasketRequestModel basketRequestModel) async {
    var result = await _basketRepo.addProductTobasket(basketRequestModel);

    result.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(isLoading: false, basket: r),
      ),
    );
  }

  Future increaseQuantity(int itemId) async {
    var result = await _basketRepo.increaseQuantity(itemId);

    result.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(isLoading: false, basket: r),
      ),
    );
  }

  Future decreaseQuantity(int itemId) async {
    var result = await _basketRepo.decreaseQuantity(itemId);

    result.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(isLoading: false, basket: r),
      ),
    );
  }

  Future deleteItem(int itemId) async {
    var result = await _basketRepo.deleteItem(itemId);

    result.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(isLoading: false, basket: r),
      ),
    );
  }

  Future clearBasket(String basketId) async {
    var result = await _basketRepo.clearBasket(basketId);

    result.fold(
      (l) {
        print(l.message);
      },
      (r) => emit(
        const BasketStates(),
      ),
    );
  }

  BasketProductModel? getBranchProduct(int branchProductId) {
    var branchProduct = state.basket?.basketProducts.firstWhereOrNull(
        (element) => element.branchProductModel?.id == branchProductId);
    return branchProduct;
  }

  reset() {
    emit(const BasketStates());
  }
}
