import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/utils/dialog_manager_overlay.dart';
import 'package:market_app_2/core/widget/filled_button_widget.dart';
import 'package:market_app_2/features/basket/data/models/basket_request_model.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/home/presentation/view_models/branch/branch_cubit.dart';
import 'package:market_app_2/features/products/data/models/branch_product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String routeName = '/product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _discriptionTextExpanded = false;

  @override
  Widget build(BuildContext context) {
    print('????? ${ModalRoute.of(context)!.settings.arguments}');
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final branchProductModel = arguments[0] as BranchProductModel;

    final heroTag = arguments[1] as String;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            // The product image
            SliverAppBar(
              elevation: 0,
              pinned: true,
              expandedHeight: 300,
              stretch: true,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  size: 25,
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.blurBackground,
                ],
                background: Hero(
                    tag: heroTag,
                    child: Container(
                        color: AppColors.white,
                        child: Image.network(
                            branchProductModel.product!.images[0]))),
              ),
            ),
            // Product body
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product name
                    Text(
                      branchProductModel.product!.enName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    // Product price
                    Text(
                      '${branchProductModel.price.toString()} ₺',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Product disc
                    // Todo >>>>>>>>>
                    InkWell(
                      onTap: () {
                        setState(() {
                          _discriptionTextExpanded = !_discriptionTextExpanded;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          branchProductModel.product!.enDescription!,
                          maxLines: _discriptionTextExpanded ? null : 2,
                          overflow: _discriptionTextExpanded
                              ? null
                              : TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
