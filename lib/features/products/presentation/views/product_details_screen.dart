import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/utils/dialog_manager_overlay.dart';
import 'package:market_app_2/core/widget/filled_button_widget.dart';
import 'package:market_app_2/features/basket/data/models/basket_request_model.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});
  static const String routeName = '/product-details-screen';

  @override
  Widget build(BuildContext context) {
    final branchProductModel =
        ModalRoute.of(context)!.settings.arguments as BranchProductModel;
    return Scaffold(
      // TODO add custome scroll view
      body: const Center(
        child: Text('Details screen'),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: FilledButtonWidget(
          onPress: () async {
            DialogManagerOverlay.showDialogWithMessage(context);
            await context.read<BasketCubit>().addToBasket(
                  BasketRequestModel(
                    branchId: context.read<BranchCubit>().state.branchModel!.id,
                    branchProductId: branchProductModel.id,
                  ),
                );

            DialogManagerOverlay.closeDialog();
            Navigator.pop(context);
          },
          widget: const Text('Add to Basket'),
        ),
      ),
    );
  }
}
