import 'package:flutter/material.dart';
import 'package:market_app_2/core/widget/shimmer_loading_widget.dart';

class CategoryListItemLoadingWidget extends StatelessWidget {
  const CategoryListItemLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            // The category image
            Expanded(
              flex: 2,
              child: ShimmerLoadingWidget(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.grey.withOpacity(.5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            // The category title
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: 3,
                  vertical: 5,
                ),
                child: ShimmerLoadingWidget(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
