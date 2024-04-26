import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repo/home_repo.dart';
import 'branch_state.dart';

class BranchCubit extends Cubit<BranchState> {
  BranchCubit(this._homeRepo) : super(const BranchState());
  final HomeRepo _homeRepo;

  Future getBranch(double lat, double lng, String? subDistrictId) async {
    var result = await _homeRepo.getBranch(
        'Lat=$lat&Lng=$lng${subDistrictId != null ? '&SubDistrictId=$subDistrictId' : ''}');

    result.fold(
      (l) {
        throw HttpException(l.message);
      },
      (r) => emit(
        BranchState(branchModel: r),
      ),
    );
  }
}
