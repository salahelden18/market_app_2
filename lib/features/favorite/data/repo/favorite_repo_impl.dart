import 'package:dartz/dartz.dart';
import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/favorite_model.dart';
import 'favorite_repo.dart';

class FavoriteRepoImpl implements FavoriteRepo {
  final HttpServiceInterface _httpServiceInterface;

  FavoriteRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, FavoriteModel?>> addFavorite(int id) async {
    return await _httpServiceInterface.post(
      url: '${EndPointConstants.baseFavorite}/$id',
      fromJson: (decodedJson) => FavoriteModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, dynamic>> deleteFavorite(String id) async {
    return await _httpServiceInterface.delete(
      url: '${EndPointConstants.baseFavorite}/$id',
      fromJson: (decodedJson) => null,
    );
  }

  @override
  Future<Either<HttpFailure, List<FavoriteModel>?>> getFavorites() async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.baseFavorite,
      fromJson: (decodedJson) => List<FavoriteModel>.from(
        decodedJson.map((e) => FavoriteModel.fromJson(e)),
      ),
    );
  }
}
