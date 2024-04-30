import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/font_style.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key, required this.message, required this.title});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          title,
          style: FontStyle.size22Black600,
        ),
        const SizedBox(height: 10),
        Text(message),
        const SizedBox(height: 30),
      ],
    );
  }
}
