import 'package:dartz/dartz.dart';
import '../models/address_common_model.dart';
import '../models/address_request_model.dart';
import '../../../../core/constants/endpoint_constants.dart';
import '../../../../core/error/http_failure.dart';
import '../../../../core/services/http_service_interface.dart';
import '../models/address_model.dart';
import 'address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  final HttpServiceInterface _httpServiceInterface;
  AddressRepoImpl(this._httpServiceInterface);

  @override
  Future<Either<HttpFailure, List<AddressModel>?>> getAddresses() async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.addressBase,
      fromJson: (decodedJson) => List<AddressModel>.from(
          decodedJson.map((e) => AddressModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getCities(
      String countryId) async {
    return await _httpServiceInterface.get(
      url: '${EndPointConstants.cityBase}/countries-cities/$countryId',
      fromJson: (decodedJson) => List<AddressCommonModel>.from(
          decodedJson.map((e) => AddressCommonModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getCountries() async {
    return await _httpServiceInterface.get(
      url: EndPointConstants.countryBase,
      fromJson: (decodedJson) => List<AddressCommonModel>.from(
          decodedJson.map((e) => AddressCommonModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getDistricts(
      String cityId) async {
    return await _httpServiceInterface.get(
      url: '${EndPointConstants.districtBase}/cities-districts/$cityId',
      fromJson: (decodedJson) => List<AddressCommonModel>.from(
          decodedJson.map((e) => AddressCommonModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, List<AddressCommonModel>?>> getSubDistricts(
      String districtId) async {
    return await _httpServiceInterface.get(
      url:
          '${EndPointConstants.subDistrictBase}/districts-subdistricts/$districtId',
      fromJson: (decodedJson) => List<AddressCommonModel>.from(
          decodedJson.map((e) => AddressCommonModel.fromJson(e))),
    );
  }

  @override
  Future<Either<HttpFailure, AddressModel?>> addAddress(
      AddressRequestModel addressRequestModel) async {
    return await _httpServiceInterface.post(
      url: EndPointConstants.addressBase,
      fromJson: (decodedJson) => AddressModel.fromJson(decodedJson),
      body: addressRequestModel.toJson(),
    );
  }

  @override
  Future<Either<HttpFailure, AddressModel?>> editAddress(
      String addressId, AddressRequestModel addressRequestModel) async {
    return await _httpServiceInterface.patch(
      url: '${EndPointConstants.addressBase}/$addressId',
      fromJson: (decodedJson) => AddressModel.fromJson(decodedJson),
      body: addressRequestModel.toJson(),
    );
  }
}
