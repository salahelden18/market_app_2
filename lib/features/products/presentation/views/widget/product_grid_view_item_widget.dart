import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/core/widget/loading_widget.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/product_details_screen.dart';
import 'package:market_app_2/features/products/presentation/views/widget/no_stock_widget.dart';
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
  //Todo: product quantity
  int _quantity = 0;
  final int _animationDuration = 250;

  @override
  Widget build(BuildContext context) {
    final isfavProduct = isProductInFavorite();
    final String heroTag =
        'product-image-hero-tag-${widget.branchProductModel.id}';
    int stock = widget.branchProductModel.stock;

    return InkWell(
      onTap: () {
        if (stock != 0) {
          Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
              arguments: [widget.branchProductModel, heroTag]);
        } else {
          showToast(context: context, msg: 'There is no Stock');
        }
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10),
              color: Colors.white,
              border: Border.all(
                  color: AppColors.primaryColor.withOpacity(.7),
                  width: _quantity != 0 ? 2 : .5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The product image
                SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Hero(
                    tag: heroTag,
                    child: Image.network(
                      widget.branchProductModel.product!.images[0],
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Add to cart button
                addToCartButtonWidget(),
                const SizedBox(height: 10),
                //
                Text(
                  widget.branchProductModel.product!.enName,
                  style: FontStyle.size18Normal,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text('${widget.branchProductModel.price.toString()} ₺'),
              ],
            ),
          ),
          // Favorite Button
          Positioned(
            // top: 5,
            right: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.5),
              child: SizedBox(
                height: 20,
                width: 20,
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
                      await context.read<FavoritesCubit>().addToFavorites(
                          widget.branchProductModel.product!.id);
                    }

                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: isLoading
                      ? const LoadingWidget()
                      : Icon(
                          isfavProduct
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: AppColors.primaryColor,
                        ),
                ),
              ),
            ),
          ),
          // No stock shape widget
          if (stock == 0) const NoStockwidget(),
        ],
      ),
    );
  }

  Center addToCartButtonWidget() {
    bool addToCartLoading = false;
    const double buttonSize = 23;
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: _animationDuration),
        height: buttonSize,
        width: _quantity != 0 ? buttonSize * 3 : buttonSize,
        decoration: BoxDecoration(
          color: _quantity != 0 ? AppColors.primaryColor : AppColors.white,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            //    Decrease quantity button
            if (_quantity != 0)
              Expanded(
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _quantity--;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text(
                      '-',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: buttonSize * .7,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                  ),
                ),
              ),
            // Product Quantity
            Expanded(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _quantity = 1;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: _animationDuration),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                        BorderRadius.circular(_quantity != 0 ? 0 : 10),
                  ),
                  child: addToCartLoading
                      ? const LoadingWidget()
                      : _quantity != 0
                          ? addToCartLoading
                              ? const LoadingWidget()
                              : Center(
                                  child: Text(
                                  _quantity.toString(),
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: buttonSize * .7,
                                  ),
                                ))
                          : const Icon(
                              Icons.add,
                              size: buttonSize * .8,
                            ),
                ),
              ),
            ),
            // Increase quantity button
            if (_quantity != 0)
              Expanded(
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      _quantity++;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: _animationDuration),
                    child: const Icon(
                      Icons.add,
                      size: buttonSize * .7,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
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
