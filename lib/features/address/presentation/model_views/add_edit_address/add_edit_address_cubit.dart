import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/address_request_model.dart';
import '../../../data/repo/address_repo.dart';
import 'add_edit_address_states.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressStates> {
  AddEditAddressCubit(this._addressRepo) : super(AddEditAddressInitialState());

  final AddressRepo _addressRepo;

  Future addEditAddress(AddressRequestModel addressRequestModel) async {
    emit(AddEditAddressLoadingState());

    var result = await _addressRepo.addAddress(addressRequestModel);

    result.fold(
      (l) {
        emit(AddEditAddressFailureState(l.message));
      },
      (r) => emit(AddEditAddressSuccessState(r!)),
    );
  }
}
