import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import 'package:market_app_2/features/products/presentation/view_model/products_cubit/products_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/widget/product_grid_view_item_widget.dart';

class RecommendedProductsWidget extends StatefulWidget {
  const RecommendedProductsWidget({
    super.key,
    required this.branchCategoryId,
  });

  final int branchCategoryId;

  @override
  State<RecommendedProductsWidget> createState() =>
      _RecommendedProductsWidgetState();
}

class _RecommendedProductsWidgetState extends State<RecommendedProductsWidget> {
  @override
  Widget build(BuildContext context) {
    final productCubit = context.watch<ProductsCubit>();
    final favCubit = context.watch<FavoritesCubit>();

    productCubit.getRecommendedProducts(widget.branchCategoryId);
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
      child: SizedBox(
        width: double.infinity,
        height: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recommended For You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
//            recommended products list
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) => SizedBox(
                  width: 180,
                  child: ProductGridViewItemWidget(
                    branchProductModel:
                        productCubit.state.recommendedProduct[index],
                    favorite: favCubit.state.favoriteProducts,
                    branchCategoryId: widget.branchCategoryId,
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 20),
                itemCount: productCubit.state.recommendedProduct.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
