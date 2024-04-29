import 'package:flutter/material.dart';

class TitleAndPriceRowWidget extends StatelessWidget {
   const TitleAndPriceRowWidget({
    super.key,
    required this.title,
    required this.price,
    this.isPriceGreenColor = false,
  });

  final String title;
  final String price;
  final bool isPriceGreenColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
              child: Text(
            price,
            style: TextStyle(
              color: isPriceGreenColor ? Colors.green : Colors.black54,
            ),
          ))
        ],
      ),
    );
  }
}
