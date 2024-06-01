import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/utils/dialog_manager_overlay.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../../core/widget/filled_button_widget.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import '../../../basket/data/models/basket_request_model.dart';
import '../../../basket/presentation/model_views/basket_cubit.dart';
import '../../../basket/presentation/views/basket_screen.dart';
import '../../../home/presentation/view_models/branch/branch_cubit.dart';
import '../../data/models/branch_product_model.dart';
import 'widget/product_details_favorite_button.dart';
import 'widget/recommended_products_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const String routeName = '/product-details-screen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _discriptionTextExpanded = false;
  String? productId;
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as List;
    final branchProductModel = arguments[0] as BranchProductModel;
    final List images = List.generate(
        branchProductModel.product!.images.length,
        (index) => Container(
            color: Colors.white,
            child: Image.network(branchProductModel.product!.images[index])));

    final heroTag = arguments[1] as String;
    int branchCategoryId = arguments[2] as int;

    productId = branchProductModel.product!.id;

    double price = getDisount(branchProductModel.discountTypes,
        branchProductModel.discountValue, branchProductModel.price);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            // // The product image
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              pinned: true,
              expandedHeight: 300,
              stretch: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      BasketScreen.routeName,
                    );
                  },
                  icon: const Icon(
                    Icons.shopping_basket_outlined,
                    size: 25,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.blurBackground,
                ],
                // Todo
                background: Container(
                  color: Colors.white,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      if (images.isNotEmpty)
                        PageView.builder(
                          onPageChanged: (value) {
                            setState(() {
                              currentImageIndex = value;
                            });
                          },
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Hero(
                                tag: heroTag,
                                child: images[index],
                              );
                            }
                            return images[index];
                          },
                          itemCount: images.length,
                        ),
                      if (images.isNotEmpty)
                        DotsIndicator(
                          dotsCount: images.length,
                          position: currentImageIndex,
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            activeSize: const Size(20.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Product body
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product price
                    Row(
                      children: [
                        if (branchProductModel.discountValue != 0)
                          Text(
                            '${branchProductModel.price} ₺',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        if (branchProductModel.discountValue != 0)
                          const SizedBox(width: 5),
                        Text(
                          '$price ₺',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        ProductDetailsFavoriteButton(
                            branchProductId: branchProductModel.id),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Product name
                    Text(
                      branchProductModel.product!.enName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
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
                    // recommended for you products
                    RecommendedProductsWidget(
                        branchCategoryId: branchCategoryId),
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
            final auth = context.read<AutoAuthenticationCubit>();
            if (auth.state.authenticationState !=
                AuthenticationStates.authenticated) {
              showToast(context: context, msg: 'Please login first');
            } else {
              DialogManagerOverlay.showDialogWithMessage(context);
              await context.read<BasketCubit>().addToBasket(
                    BasketRequestModel(
                      branchId:
                          context.read<BranchCubit>().state.branchModel!.id,
                      branchProductId: branchProductModel.id,
                    ),
                  );

              DialogManagerOverlay.closeDialog();
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
          widget: const Text('Add to Basket'),
        ),
      ),
    );
  }
}

double getDisount(int? discountType, double? discountValue, double price) {
  if (discountType == null ||
      discountValue == null ||
      discountType == 0 ||
      discountValue == 0) {
    return price;
  }

  // If the discount percentage
  if (discountType == 0) {
    return price * (discountValue / 100);
  }

  return price - discountValue;
}
