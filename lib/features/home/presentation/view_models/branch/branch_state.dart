import 'package:equatable/equatable.dart';
import 'package:market_app_2/features/home/data/models/branch_model.dart';

class BranchState extends Equatable {
  final BranchModel? branchModel;

  const BranchState({this.branchModel});

  @override
  List<Object?> get props => [];
}
