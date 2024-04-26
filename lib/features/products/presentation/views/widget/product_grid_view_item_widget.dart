import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/widget/loading_widget.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/product_details_screen.dart';
import '../../../../../core/style/font_style.dart';
import '../../../../favorite/data/models/favorite_model.dart';
import '../../../data/models/branch_product_model.dart';

class ProductGridViewItemWidget extends StatefulWidget {
  const ProductGridViewItemWidget(
      {super.key, required this.branchProductModel, required this.favorite});
  final BranchProductModel branchProductModel;
  final List<FavoriteModel> favorite;

  @override
  State<ProductGridViewItemWidget> createState() =>
      _ProductGridViewItemWidgetState();
}

class _ProductGridViewItemWidgetState extends State<ProductGridViewItemWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isfavProduct = isProductInFavorite();
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
            arguments: widget.branchProductModel);
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Image.network(
                    widget.branchProductModel.product!.images[0],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.branchProductModel.product!.enName,
                  style: FontStyle.size18Normal,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(widget.branchProductModel.price.toString()),
              ],
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                if (isfavProduct) {
                  await context
                      .read<FavoritesCubit>()
                      .deleteFromFavorites(getProductId()!);
                } else {
                  await context
                      .read<FavoritesCubit>()
                      .addToFavorites(widget.branchProductModel.product!.id);
                }

                setState(() {
                  isLoading = false;
                });
              },
              child: isLoading
                  ? const LoadingWidget()
                  : Icon(
                      isfavProduct ? Icons.favorite : Icons.favorite_outline,
                      color: AppColors.primaryColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }

  bool isProductInFavorite() {
    var index = widget.favorite.indexWhere((element) =>
        element.product.id == widget.branchProductModel.product!.id);

    if (index != -1) {
      return true;
    } else {
      return false;
    }
  }

  String? getProductId() {
    var index = widget.favorite.indexWhere((element) =>
        element.product.id == widget.branchProductModel.product!.id);

    if (index != -1) {
      return widget.favorite[index].id;
    } else {
      return null;
    }
  }
}
