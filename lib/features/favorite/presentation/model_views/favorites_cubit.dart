import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/favorite/data/models/favorite_model.dart';
import '../../data/repo/favorite_repo.dart';
import 'favorites_states.dart';

class FavoritesCubit extends Cubit<FavoriteStates> {
  FavoritesCubit(this._favoriteRepo) : super(const FavoriteStates());
  final FavoriteRepo _favoriteRepo;

  Future getFavorites() async {
    emit(state.copyWith(isLoading: true));

    final result = await _favoriteRepo.getFavorites();

    result.fold(
      (l) => emit(state.copyWith(isLoading: false)),
      (r) {
        emit(state.copyWith(isLoading: false, favoriteProducts: r));
      },
    );
  }

  Future addToFavorites(int id) async {
    var result = await _favoriteRepo.addFavorite(id);

    result.fold(
      (l) => null,
      (r) {
        var favorites = List<FavoriteModel>.from(state.favoriteProducts)
          ..add(r!);

        emit(state.copyWith(favoriteProducts: favorites));
      },
    );
  }

  Future deleteFromFavorites(String id) async {
    var result = await _favoriteRepo.deleteFavorite(id);

    result.fold(
      (l) => null,
      (r) {
        var favorites = List<FavoriteModel>.from(state.favoriteProducts)
          ..removeWhere((element) => element.id == id);

        emit(state.copyWith(favoriteProducts: favorites));
      },
    );
  }
}
