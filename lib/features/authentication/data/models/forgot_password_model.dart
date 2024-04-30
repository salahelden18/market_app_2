import 'package:equatable/equatable.dart';

class ForgotPasswordModel extends Equatable {
  final String email;

  const ForgotPasswordModel(this.email);

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }

  @override
  List<Object?> get props => [email];
}
