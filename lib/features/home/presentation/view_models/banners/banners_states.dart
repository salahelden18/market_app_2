import 'package:equatable/equatable.dart';

import '../../../data/models/banners_model.dart';

abstract class BannersStates extends Equatable {
  const BannersStates();

  @override
  List<Object> get props => [];
}

class BannersInitialState extends BannersStates {}

class BannersLoadingState extends BannersStates {}

class BannersSuccessState extends BannersStates {
  final List<BannerModel> banners;

  const BannersSuccessState(this.banners);

  @override
  List<Object> get props => [banners];
}

class BannersFailureState extends BannersStates {
  final String errorMessage;

  const BannersFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
