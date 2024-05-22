import 'package:flutter/widgets.dart';
import 'package:market_app_2/features/products/presentation/views/widget/shimmer_loading_widgets/product_grid_view_item_loading_widget.dart';

class GridListViewLoadingWidget extends StatelessWidget {
  const GridListViewLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        mainAxisExtent: 190,
      ),
      itemBuilder: (ctx, index) => const ProductGridViewLoadingItemWidget(),
      itemCount: 10,
    );
  }
}
