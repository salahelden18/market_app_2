import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingWidget extends StatelessWidget {
  const ShimmerLoadingWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: child);
  }
}
