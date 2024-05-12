import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/favorite/data/models/favorite_model.dart';

abstract class FavoriteRepo {
  Future<Either<HttpFailure, List<FavoriteModel>?>> getFavorites();
  Future<Either<HttpFailure, FavoriteModel?>> addFavorite(int id);
  Future<Either<HttpFailure, dynamic>> deleteFavorite(String id);
}
