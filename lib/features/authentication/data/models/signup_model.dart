import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String userId;
  final String message;

  const SignupModel({required this.message, required this.userId});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(message: json['message'], userId: json['userId']);
  }

  @override
  List<Object?> get props => [userId, message];
}
