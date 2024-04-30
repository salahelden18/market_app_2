import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/profile/data/models/user_profile_model.dart';

abstract class ProfileStates extends Equatable {
  const ProfileStates();

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}

class ProfileSuccessState extends ProfileStates {
  final UserProfileModel? userProfileModel;

  const ProfileSuccessState(this.userProfileModel);

  @override
  List<Object> get props => [userProfileModel ?? ''];
}

class ProfileFailureState extends ProfileStates {
  final String errorMessage;

  const ProfileFailureState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
