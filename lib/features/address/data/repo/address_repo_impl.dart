import 'package:dartz/dartz.dart';
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
}
