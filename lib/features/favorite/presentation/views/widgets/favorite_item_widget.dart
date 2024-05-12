import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/widget/loading_widget.dart';
import '../../model_views/favorites_cubit.dart';
import '../../../../../core/style/font_style.dart';
import '../../../../products/presentation/views/product_details_screen.dart';
import '../../../data/models/favorite_model.dart';

class FavoriteItemWidget extends StatefulWidget {
  const FavoriteItemWidget({super.key, required this.favoriteModel});
  final FavoriteModel favoriteModel;

  @override
  State<FavoriteItemWidget> createState() => _FavoriteItemWidgetState();
}

class _FavoriteItemWidgetState extends State<FavoriteItemWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final String heroTag =
        'product-image-hero-tag-${widget.favoriteModel.branchProduct.id}';
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetailsScreen.routeName, arguments: [
          widget.favoriteModel.branchProduct,
          heroTag,
          widget.favoriteModel.branchProduct.branchSubCategoryModel
                  ?.branchCategoryId ??
              1,
        ]);
      },
      child: Container(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Image.network(
                widget.favoriteModel.branchProduct.product!.images[0],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.favoriteModel.branchProduct.product!.enName,
                      style: FontStyle.size22Black600,
                    ),
                    if (widget.favoriteModel.branchProduct.product
                            ?.enDescription !=
                        null)
                      const SizedBox(height: 5),
                    if (widget.favoriteModel.branchProduct.product
                            ?.enDescription !=
                        null)
                      Text(widget
                          .favoriteModel.branchProduct.product!.enDescription!),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 20,
                width: 20,
                child: GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });

                    await context
                        .read<FavoritesCubit>()
                        .deleteFromFavorites(widget.favoriteModel.id);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: isLoading
                      ? const LoadingWidget()
                      : const Icon(
                          Icons.favorite,
                          color: AppColors.primaryColor,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
