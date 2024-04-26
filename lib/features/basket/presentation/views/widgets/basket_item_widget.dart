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
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
            arguments: basketProductModel.branchProductModel);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGray),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Image.network(
                basketProductModel.branchProductModel.product!.images[0],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(basketProductModel.branchProductModel.product!.enName),
                  const SizedBox(height: 5),
                  Text(basketProductModel
                          .branchProductModel.product?.enDescription ??
                      ''),
                  const SizedBox(height: 10),
                  Text(basketProductModel.branchProductModel.price.toString()),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.primaryColor),
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
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(height: 5),
                  Text(basketProductModel.quantity.toString()),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () async {
                      await context
                          .read<BasketCubit>()
                          .decreaseQuantity(basketProductModel.id);
                    },
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
