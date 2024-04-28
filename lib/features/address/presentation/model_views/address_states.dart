import 'package:equatable/equatable.dart';

import '../../data/models/address_model.dart';

class AddressStates extends Equatable {
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;
  final AddressModel? selectedAddress;
  final List<AddressModel> addresses;

  const AddressStates({
    this.addresses = const [],
    this.hasError = false,
    this.selectedAddress,
    this.isLoading = false,
    this.errorMessage,
  });

  AddressStates copyWith({
    AddressModel? selectedAddress,
    List<AddressModel>? addresses,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return AddressStates(
      addresses: addresses ?? this.addresses,
      selectedAddress: selectedAddress ?? this.selectedAddress,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [selectedAddress, addresses, isLoading, errorMessage];
}
