import 'package:dartz/dartz.dart';
import 'package:market_app_2/core/error/http_failure.dart';
import 'package:market_app_2/features/address/data/models/address_model.dart';

abstract class AddressRepo {
  Future<Either<HttpFailure, List<AddressModel>?>> getAddresses();
}
