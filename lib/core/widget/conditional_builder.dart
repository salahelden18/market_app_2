import 'package:flutter/cupertino.dart';

class ConditionalBuilder extends StatelessWidget {
  final bool condition;
  final Widget isTrueWidget;
  final Widget isFalseWidget;

  const ConditionalBuilder(
      {super.key,
      required this.condition,
      required this.isTrueWidget,
      required this.isFalseWidget});

  @override
  Widget build(BuildContext context) {
    return condition ? isTrueWidget : isFalseWidget;
  }
}
