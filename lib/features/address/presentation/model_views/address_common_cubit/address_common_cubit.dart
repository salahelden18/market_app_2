import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/address_repo.dart';
import 'address_common_states.dart';

class AddressCommonCubit extends Cubit<AddressCommonStates> {
  AddressCommonCubit(this._addressRepo) : super(const AddressCommonStates());

  final AddressRepo _addressRepo;

  Future getCountries() async {
    emit(state.copyWith(isLoading: true));

    var result = await _addressRepo.getCountries();

    result.fold(
      (l) {
        emit(state.copyWith(
            isLoading: false, hasError: true, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(
          hasError: false,
          countries: r,
          isLoading: false,
        ));
      },
    );
  }

  Future getCities(String countryId) async {
    emit(state.copyWith(isLoading: true));

    var result = await _addressRepo.getCities(countryId);

    result.fold(
      (l) {
        emit(state.copyWith(
            isLoading: false, hasError: true, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(
          hasError: false,
          cities: r,
          isLoading: false,
        ));
      },
    );
  }

  Future getDistrict(String cityId) async {
    emit(state.copyWith(isLoading: true));

    var result = await _addressRepo.getDistricts(cityId);

    result.fold(
      (l) {
        emit(state.copyWith(
            isLoading: false, hasError: true, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(
          hasError: false,
          districts: r,
          isLoading: false,
        ));
      },
    );
  }

  Future getSubDistrict(String districtId) async {
    emit(state.copyWith(isLoading: true));

    var result = await _addressRepo.getSubDistricts(districtId);

    result.fold(
      (l) {
        emit(state.copyWith(
            isLoading: false, hasError: true, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(
          hasError: false,
          subdistricts: r,
          isLoading: false,
        ));
      },
    );
  }
}
