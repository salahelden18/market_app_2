import 'package:equatable/equatable.dart';

class BranchSubCategoryModel extends Equatable {
  final int id;
  final bool isEnabled;
  final int? branchCategoryId;

  const BranchSubCategoryModel({
    required this.id,
    required this.branchCategoryId,
    required this.isEnabled,
  });

  factory BranchSubCategoryModel.fromJson(Map<String, dynamic> json) {
    return BranchSubCategoryModel(
      id: json['id'],
      branchCategoryId: json['branchSubCategory'],
      isEnabled: json['isEnabled'],
    );
  }

  @override
  List<Object?> get props => [id, isEnabled, branchCategoryId];
}
