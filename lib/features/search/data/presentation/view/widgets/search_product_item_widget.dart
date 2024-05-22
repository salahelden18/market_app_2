import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';

class SearchProductItemWidget extends StatelessWidget {
  const SearchProductItemWidget({
    super.key,
    required this.model,
  });
  final BranchProductModel model;

  @override
  Widget build(BuildContext context) {
    final String currencySymbol =
        context.read<BranchCubit>().state.branchModel!.currencySymbol!;
    return Container(
      padding: const EdgeInsetsDirectional.all(7),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadiusDirectional.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Proddut image
          Expanded(child: Image.network(model.product!.images[0])),
          // Product name
          Text(
            model.product!.enName,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          // Product desc
          Text(
            model.product!.enDescription!,
            maxLines: 1,
          ),
          // Product price
          Text(
            '${model.price} $currencySymbol',
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
