import 'package:equatable/equatable.dart';

class VerifyRequestModel extends Equatable {
  final String userId;
  final String otp;

  const VerifyRequestModel({required this.otp, required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'otp': otp,
    };
  }

  @override
  List<Object?> get props => [userId, otp];
}
