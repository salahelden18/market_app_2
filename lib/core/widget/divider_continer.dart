import 'package:flutter/material.dart';

class DividerContiner extends StatelessWidget {
  const DividerContiner({
    super.key,
    this.isVertical = false,
    this.color = Colors.grey,
  });

  final bool isVertical;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: isVertical ? double.infinity : 1,
      width: isVertical ? 1 : double.infinity,
    );
  }
}
