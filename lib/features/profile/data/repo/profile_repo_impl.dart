import 'package:dartz/dartz.dart';
import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/user_profile_model.dart';
import 'profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final HttpServiceInterface _httpServiceInterface;

  ProfileRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, UserProfileModel?>> getProfile() async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.userBase,
      fromJson: (decodedJson) => UserProfileModel.fromJson(decodedJson),
    );
  }

  @override
  Future<Either<HttpFailure, Map<String, String>?>> editProfile({
    required String fullName,
    required String phoneNumber,
  }) {
    return _httpServiceInterface.patch(
      url: EndPointConstants.userBase,
      body: {"fullName": fullName, "phoneNumber": phoneNumber},
      fromJson: (p0) {
        return null;
      },
    );
  }
}
