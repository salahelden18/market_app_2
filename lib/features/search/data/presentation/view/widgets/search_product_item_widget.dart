import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';
import 'package:market_app_2/features/products/presentation/views/product_details_screen.dart';

class SearchProductItemWidget extends StatelessWidget {
  const SearchProductItemWidget({
    super.key,
    required this.model,
  });
  final BranchProductModel model;

  @override
  Widget build(BuildContext context) {
    final heroTag = 'product-hero-tag-${model.product!.id}';
    final String currencySymbol =
        context.read<BranchCubit>().state.branchModel!.currencySymbol!;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: [model, heroTag, 0]);
      },
      child: Container(
        padding: const EdgeInsetsDirectional.all(7),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 41, 41, 41)),
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
      ),
    );
  }
}
