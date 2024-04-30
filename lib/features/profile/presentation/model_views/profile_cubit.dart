import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repo/profile_repo.dart';
import 'profile_states.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit(this._profileRepo) : super(ProfileInitialState());

  final ProfileRepo _profileRepo;

  Future getProfile() async {
    emit(ProfileLoadingState());

    var result = await _profileRepo.getProfile();

    result.fold(
      (l) => emit(ProfileFailureState(l.message)),
      (r) => emit(ProfileSuccessState(r)),
    );
  }

  reset() {
    emit(ProfileInitialState());
  }
}
