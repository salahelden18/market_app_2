import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/data/repo/home_repo.dart';
import 'package:market_app_2/features/home/presentation/view_models/banners/banners_states.dart';

class BannersCubit extends Cubit<BannersStates> {
  BannersCubit(this._homeRepo) : super(BannersInitialState());
  final HomeRepo _homeRepo;

  Future getBanners() async {
    emit(BannersLoadingState());

    var result = await _homeRepo.getBanners();

    result.fold(
      (l) => emit(BannersFailureState(l.message)),
      (r) => emit(BannersSuccessState(r!)),
    );
  }
}
