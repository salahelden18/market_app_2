import 'package:equatable/equatable.dart';

class OrderLottieModel extends Equatable {
  final String title;
  final String description;
  final String lottieFile;

  const OrderLottieModel(
      {required this.description,
      required this.lottieFile,
      required this.title});

  @override
  List<Object?> get props => [title, description, lottieFile];
}
