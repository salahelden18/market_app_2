import 'package:equatable/equatable.dart';

class UserProfileModel extends Equatable {
  final String id;
  final String userId;
  final String registerationDate;
  final String fullName;
  final String? phoneNumber;
  final String? fcmToken;
  final String email;
  final bool isActive;

  const UserProfileModel({
    required this.email,
    required this.fcmToken,
    required this.fullName,
    required this.id,
    required this.isActive,
    required this.phoneNumber,
    required this.registerationDate,
    required this.userId,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      email: json['email'],
      fcmToken: json['fcmToken'],
      fullName: json['fullName'],
      id: json['id'],
      isActive: json['isActive'],
      phoneNumber: json['phoneNumber'],
      registerationDate: json['registerationDate'],
      userId: json['userId'],
    );
  }

  @override
  List<Object?> get props => [
        email,
        fcmToken,
        fullName,
        id,
        isActive,
        phoneNumber,
        registerationDate,
        userId
      ];
}
