import 'package:equatable/equatable.dart';

import '../../data/models/favorite_model.dart';

class FavoriteStates extends Equatable {
  final bool isLoading;
  final List<FavoriteModel> favoriteProducts;

  const FavoriteStates({
    this.favoriteProducts = const [],
    this.isLoading = false,
  });

  FavoriteStates copyWith({
    bool? isLoading,
    List<FavoriteModel>? favoriteProducts,
  }) {
    return FavoriteStates(
      favoriteProducts: favoriteProducts ?? this.favoriteProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [isLoading, favoriteProducts];
}
