import 'package:flutter/material.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/categories_list_loading_widget.dart';

class CategoriesLoadingShimmer extends StatelessWidget {
  const CategoriesLoadingShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
        mainAxisExtent: 120,
      ),
      itemBuilder: (context, index) => const CategoryListItemLoadingWidget(),
      itemCount: 8,
    );
  }
}
