import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    super.key,
    required this.onPress,
    required this.widget,
    this.backgroundColor,
  });
  final VoidCallback? onPress;
  final Widget widget;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 53,
      child: FilledButton(
        onPressed: onPress,
        style: FilledButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: widget,
      ),
    );
  }
}
