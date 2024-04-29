import 'package:flutter/material.dart';

class NoStockwidget extends StatelessWidget {
  const NoStockwidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
