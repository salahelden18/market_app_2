import 'package:equatable/equatable.dart';

class AuthenticationRequestModel extends Equatable {
  final String email;
  final String password;
  final String? fullName;

  const AuthenticationRequestModel({
    required this.email,
    required this.fullName,
    required this.password,
  });

  factory AuthenticationRequestModel.fromJson(Map<String, dynamic> json) {
    return AuthenticationRequestModel(
      email: json['email'],
      fullName: json['fullName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'fullName': fullName,
    }..removeWhere((key, value) => value == null || value == '');
  }

  @override
  List<Object?> get props => [email, password, fullName];
}
