import 'package:equatable/equatable.dart';

class BasketRequestModel extends Equatable {
  final int branchProductId;
  final String branchId;

  const BasketRequestModel(
      {required this.branchId, required this.branchProductId});

  Map<String, dynamic> toJson() {
    return {
      'branchProductId': branchProductId,
      'branchId': branchId,
    };
  }

  @override
  List<Object?> get props => [branchId, branchProductId];
}
