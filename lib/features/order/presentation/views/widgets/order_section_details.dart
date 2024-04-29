import 'package:flutter/material.dart';

import '../../../../../core/style/app_colors.dart';

// ignore: must_be_immutable
class OrderSectionDetails extends StatelessWidget {
  OrderSectionDetails({
    super.key,
    required this.sectionTitle,
    required this.sectionBody,
    this.onTap,
  });

  final String sectionTitle;
  Widget sectionBody;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The title of the section
          Text(
            sectionTitle,
          ),
          // The section details
          Container(
            width: double.infinity,
            margin: const EdgeInsetsDirectional.symmetric(vertical: 10),
            padding: const EdgeInsetsDirectional.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightGray, width: 1.5),
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                onTap!();
              },
              child: sectionBody,
            ),
          ),
        ],
      ),
    );
  }
}
