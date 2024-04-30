import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/authentication/data/models/verify_request_model.dart';
import '../models/authentication_request_model.dart';
import '../models/forgot_password_model.dart';
import '../models/login_model.dart';
import '../models/signup_model.dart';

abstract class AuthenticationRepo {
  Future<Either<HttpFailure, String?>> configFCM();
  Future<Either<HttpFailure, SignupModel?>> signup(
      AuthenticationRequestModel authenticationRequestModel);
  Future<Either<HttpFailure, LoginModel?>> login(
      AuthenticationRequestModel authenticationRequestModel);

  Future<Either<HttpFailure, LoginModel?>> verify(
      VerifyRequestModel verifyRequestModel);
  Future<Either<HttpFailure, SignupModel?>> forgotPassword(
      ForgotPasswordModel forgotPasswordModel);
}
