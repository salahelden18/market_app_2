import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String userId;
  final String? role;
  final String? token;
  final String? message;

  const LoginModel({
    required this.message,
    required this.role,
    required this.token,
    required this.userId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      message: json['message'],
      role: json['role'],
      token: json['token'],
      userId: json['userId'],
    );
  }

  @override
  List<Object?> get props => [userId, token, role, message];
}
