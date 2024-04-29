import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/constants/animation_constants.dart';

class CancelLottieWidget extends StatelessWidget {
  const CancelLottieWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(AnimationConstants.canceled),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
