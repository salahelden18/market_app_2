import 'package:equatable/equatable.dart';

import '../../../data/models/address_common_model.dart';

class AddressCommonStates extends Equatable {
  final List<AddressCommonModel> countries;
  final List<AddressCommonModel> cities;
  final List<AddressCommonModel> districts;
  final List<AddressCommonModel> subdistricts;
  final bool hasError;
  final String? errorMessage;
  final bool isLoading;

  const AddressCommonStates({
    this.cities = const [],
    this.countries = const [],
    this.districts = const [],
    this.subdistricts = const [],
    this.errorMessage,
    this.hasError = false,
    this.isLoading = false,
  });

  AddressCommonStates copyWith({
    List<AddressCommonModel>? countries,
    List<AddressCommonModel>? cities,
    List<AddressCommonModel>? districts,
    List<AddressCommonModel>? subdistricts,
    bool? hasError,
    String? errorMessage,
    bool? isLoading,
  }) {
    return AddressCommonStates(
      countries: countries ?? this.countries,
      cities: cities ?? this.cities,
      districts: districts ?? this.districts,
      subdistricts: subdistricts ?? this.subdistricts,
      errorMessage: errorMessage ?? this.errorMessage,
      hasError: hasError ?? this.hasError,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        countries,
        cities,
        districts,
        subdistricts,
        hasError,
        errorMessage,
        isLoading
      ];
}
