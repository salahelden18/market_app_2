import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../data/models/basket_product_model.dart';
import '../../model_views/basket_cubit.dart';
import '../../../../products/presentation/views/product_details_screen.dart';

class BasketItemWidget extends StatelessWidget {
  const BasketItemWidget({super.key, required this.basketProductModel});
  final BasketProductModel basketProductModel;
  @override
  Widget build(BuildContext context) {
    final String heroTag =
        'product-image-hero-tag-${basketProductModel.branchProductModel?.id}';
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
            arguments: [basketProductModel.branchProductModel, heroTag]);
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 10,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGray),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Hero(
                  tag: heroTag,
                  child: Image.network(
                    basketProductModel.branchProductModel!.product!.images[0],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      basketProductModel.branchProductModel!.product!.enName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      basketProductModel
                              .branchProductModel!.product?.enDescription ??
                          '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                        '${basketProductModel.branchProductModel!.price.toString()} ₺'),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: AppColors.primaryColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<BasketCubit>()
                            .increaseQuantity(basketProductModel.id);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(5),
                            topEnd: Radius.circular(5),
                          ),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      basketProductModel.quantity.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: AppColors.primaryColor),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () async {
                        print('Entered the on Tap in the delete part');
                        print(basketProductModel.quantity);
                        if (basketProductModel.quantity == 1) {
                          await context
                              .read<BasketCubit>()
                              .deleteItem(basketProductModel.id);
                        } else {
                          await context
                              .read<BasketCubit>()
                              .decreaseQuantity(basketProductModel.id);
                        }
                      },
                      child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(5),
                              bottomEnd: Radius.circular(5),
                            ),
                          ),
                          child: Icon(
                              basketProductModel.quantity == 1
                                  ? Icons.delete
                                  : Icons.remove,
                              color: AppColors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
