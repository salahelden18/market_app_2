import 'package:dartz/dartz.dart';
import 'package:market_app_2/features/authentication/data/models/verify_request_model.dart';
import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/authentication_request_model.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';
import 'authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final HttpServiceInterface _httpServiceInterface;

  AuthenticationRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, LoginModel?>> login(
      AuthenticationRequestModel authenticationRequestModel) async {
    return await _httpServiceInterface.post(
      url: EndPointConstants.login,
      fromJson: (decodedJson) => LoginModel.fromJson(decodedJson),
      body: authenticationRequestModel.toJson(),
      requireToken: false,
    );
  }

  @override
  Future<Either<HttpFailure, SignupModel?>> signup(
      AuthenticationRequestModel authenticationRequestModel) async {
    return await _httpServiceInterface.post(
      url: EndPointConstants.signup,
      fromJson: (decodedJson) => SignupModel.fromJson(decodedJson),
      body: authenticationRequestModel.toJson(),
      requireToken: false,
    );
  }

  @override
  Future<Either<HttpFailure, LoginModel?>> verify(
      VerifyRequestModel verifyRequestModel) async {
    return await _httpServiceInterface.post(
        url: EndPointConstants.verify,
        fromJson: (decodedJson) => LoginModel.fromJson(decodedJson),
        requireToken: false,
        body: verifyRequestModel.toJson());
  }
}
