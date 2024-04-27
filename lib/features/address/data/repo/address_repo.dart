import 'package:dartz/dartz.dart';
import '../../../../core/error/http_failure.dart';
import '../models/address_common_model.dart';
import '../models/address_model.dart';
import '../models/address_request_model.dart';

abstract class AddressRepo {
  Future<Either<HttpFailure, List<AddressModel>?>> getAddresses();

  Future<Either<HttpFailure, List<AddressCommonModel>?>> getCountries();
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getCities(
      String countryId);
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getDistricts(
      String cityId);
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getSubDistricts(
      String districtId);

  Future<Either<HttpFailure, AddressModel?>> addAddress(
      AddressRequestModel addressRequestModel);
  Future<Either<HttpFailure, AddressModel?>> editAddress(
    String addressId,
    AddressRequestModel addressRequestModel,
  );
}
