import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../data/models/order_lottie_model.dart';

class LottieContainerWidget extends StatelessWidget {
  const LottieContainerWidget({super.key, required this.lottie});
  final OrderLottieModel lottie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          lottie.lottieFile,
          height: 250,
          width: double.infinity,
        ),
        const SizedBox(height: 10),
        Text(
          lottie.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          lottie.description,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
