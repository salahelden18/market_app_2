import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/home/data/models/branch_model.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';

class MinimumDeliveryWidget extends StatelessWidget {
  const MinimumDeliveryWidget({
    super.key,
    required this.totalPrice,
  });

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final BranchModel branchModel =
        context.watch<BranchCubit>().state.branchModel as BranchModel;
    return Column(
      children: [
        LinearProgressIndicator(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(
                totalPrice >= branchModel.minimumOrderValue! ? 0 : 5),
            bottomEnd: Radius.circular(
                totalPrice >= branchModel.minimumOrderValue! ? 0 : 5),
          ),
          backgroundColor: AppColors.primaryColor.withOpacity(.4),
          value: totalPrice >= branchModel.minimumOrderValue!
              ? 100
              : totalPrice / branchModel.minimumOrderValue!,
          minHeight: 10,
        ),
        Container(
          height: 45,
          width: double.infinity,
          color: AppColors.primaryColor.withOpacity(.2),
          child: Center(
              child: Text(totalPrice < branchModel.minimumOrderValue!
                  ? 'Minimum spend is ${branchModel.minimumOrderValue} ${branchModel.currencySymbol}, Just ${branchModel.minimumOrderValue! - totalPrice} ${branchModel.currencySymbol} more to go'
                  : 'You\'re ready to order 😊')),
        ),
      ],
    );
  }
}
