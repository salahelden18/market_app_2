import 'package:equatable/equatable.dart';

class ExceptionModel extends Equatable {
  final String message;

  const ExceptionModel({required this.message});

  factory ExceptionModel.fromJson(Map<String, dynamic> json) {
    return ExceptionModel(message: json['message'][0]);
  }

  @override
  List<Object?> get props => [message];
}
