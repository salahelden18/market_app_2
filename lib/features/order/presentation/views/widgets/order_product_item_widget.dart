import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/product_details_screen.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../basket/data/models/basket_product_model.dart';

class OrderProductItemWidget extends StatelessWidget {
  const OrderProductItemWidget({super.key, required this.basketProductModel});
  final BasketProductModel basketProductModel;

  @override
  Widget build(BuildContext context) {
    final String currencySymbol =
        context.read<BranchCubit>().state.branchModel!.currencySymbol!;
    final bool isThereDiscount =
        basketProductModel.branchProductModel!.discountValue != 0;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.lightGray),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Image.network(
              basketProductModel.branchProductModel!.product!.images[0],
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  basketProductModel.branchProductModel!.product!.enName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                Text('Quantity: ${basketProductModel.quantity}'),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      '${basketProductModel.branchProductModel!.price.toString()} $currencySymbol',
                      style: TextStyle(
                        decoration:
                            isThereDiscount ? TextDecoration.lineThrough : null,
                        fontWeight: FontWeight.bold,
                        color: isThereDiscount
                            ? Colors.grey
                            : AppColors.primaryColor,
                        fontSize: isThereDiscount ? 13 : null,
                      ),
                    ),
                    const SizedBox(width: 5),
                    if (isThereDiscount)
                      Text(
                        '${getDisount(basketProductModel.branchProductModel!.discountTypes!, basketProductModel.branchProductModel!.discountValue!, basketProductModel.branchProductModel!.price)} $currencySymbol',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
