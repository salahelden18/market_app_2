import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/address/data/models/address_model.dart';

abstract class AddEditAddressStates extends Equatable {
  const AddEditAddressStates();

  @override
  List<Object> get props => [];
}

class AddEditAddressInitialState extends AddEditAddressStates {}

class AddEditAddressLoadingState extends AddEditAddressStates {}

class AddEditAddressSuccessState extends AddEditAddressStates {
  final AddressModel address;

  const AddEditAddressSuccessState(this.address);

  @override
  List<Object> get props => [address];
}

class AddEditAddressFailureState extends AddEditAddressStates {
  final String errorMessage;

  const AddEditAddressFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
