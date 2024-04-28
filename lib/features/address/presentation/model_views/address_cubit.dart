import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../data/models/address_model.dart';
import '../../data/repo/address_repo.dart';
import 'address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  AddressCubit(this._addressRepo, this._sharedPreferencesService)
      : super(const AddressStates());

  final AddressRepo _addressRepo;
  final SharedPreferencesService _sharedPreferencesService;

  Future getAddresses() async {
    emit(state.copyWith(isLoading: true));

    var result = await _addressRepo.getAddresses();

    await result.fold(
      (l) async {
        emit(state.copyWith(errorMessage: l.message, hasError: true));
      },
      (r) async {
        if (r != null) {
          String? addressId = await _sharedPreferencesService
              .getData<String>(StringConstants.addresssId);
          AddressModel? selectedAddress;

          // if there is saved address search the addresses for this id
          if (addressId != null) {
            selectedAddress = r.firstWhere(
              (element) => element.id == addressId,
            );
          }

          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: null,
              hasError: false,
              addresses: r,
              selectedAddress: selectedAddress,
            ),
          );
        }
      },
    );
  }

  Future selectAddress(AddressModel addressModel) async {
    await _sharedPreferencesService.setData<String>(
        StringConstants.addresssId, addressModel.id);

    emit(state.copyWith(selectedAddress: addressModel));
  }

  Future addAddress(AddressModel addressModel) async {
    await _sharedPreferencesService.setData<String>(
        StringConstants.addresssId, addressModel.id);

    List<AddressModel> addresses = List<AddressModel>.from(state.addresses)
      ..add(addressModel);

    emit(state.copyWith(addresses: addresses, selectedAddress: addressModel));
  }

  Future updateAddress(AddressModel addressModel) async {
    await _sharedPreferencesService.setData<String>(
        StringConstants.addresssId, addressModel.id);

    var addresses = state.addresses
        .map((e) => e.id == addressModel.id ? addressModel : e)
        .toList();

    emit(state.copyWith(addresses: addresses, selectedAddress: addressModel));
  }
}
