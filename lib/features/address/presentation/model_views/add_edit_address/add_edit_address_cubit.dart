import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/http_failure.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/address_request_model.dart';
import '../../../data/repo/address_repo.dart';
import 'add_edit_address_states.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressStates> {
  AddEditAddressCubit(this._addressRepo) : super(AddEditAddressInitialState());

  final AddressRepo _addressRepo;

  Future addEditAddress(
      AddressRequestModel addressRequestModel, String? id) async {
    print('---------');
    print(id);
    print('---------');
    emit(AddEditAddressLoadingState());

    Either<HttpFailure, AddressModel?> result;
    // here it is adding
    if (id == null) {
      result = await _addressRepo.addAddress(addressRequestModel);
      // here for editing
    } else {
      result = await _addressRepo.editAddress(id, addressRequestModel);
    }

    result.fold(
      (l) {
        emit(AddEditAddressFailureState(l.message));
      },
      (r) => emit(AddEditAddressSuccessState(r!)),
    );
  }
}
