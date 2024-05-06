import 'package:dartz/dartz.dart';
import '../../../../core/error/http_failure.dart';
import '../models/user_profile_model.dart';

abstract class ProfileRepo {
  Future<Either<HttpFailure, UserProfileModel?>> getProfile();
  Future<Either<HttpFailure, Map<String, String>?>> editProfile({
    required String fullName,
    required String phoneNumber,
  });
}
