import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';
import 'package:market_app_2/features/products/presentation/views/widget/shimmer_loading_widgets/tab_bar_view_item_loading_widget.dart';
import '../../../../favorite/presentation/model_views/favorites_cubit.dart';
import '../../../../favorite/presentation/model_views/favorites_states.dart';
import '../../../../../core/style/font_style.dart';
import '../../../../home/presentation/view_models/branch/branch_cubit.dart';
import '../../view_model/products_cubit/products_cubit.dart';
import 'tab_header_container_widget.dart';
import '../../../data/models/custome_product_model.dart';
import 'product_grid_view_item_widget.dart';

class TabBarViewItemWidget extends StatefulWidget {
  const TabBarViewItemWidget({super.key, required this.branchCategoryModel});
  final BranchCategoryModel branchCategoryModel;

  @override
  State<TabBarViewItemWidget> createState() => _TabBarViewItemWidgetState();
}

class _TabBarViewItemWidgetState extends State<TabBarViewItemWidget> {
  bool isLoading = false;
  late CustomProductModel item;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    // check if the branch with that id contains data or not or called before or not
    item = context.read<ProductsCubit>().state.products.firstWhere((element) =>
        element.branchCategoryModel.id == widget.branchCategoryModel.id);
    final branch = context.read<BranchCubit>();

    if (!item.isLoadedBefore) {
      setState(() {
        isLoading = true;
      });
      await context
          .read<ProductsCubit>()
          .getData(branch.state.branchModel!.id, item.branchCategoryModel.id);

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductsCubit>();
    return isLoading
        ? const TabBarViewItemLoadingWidget()
        : BlocBuilder<FavoritesCubit, FavoriteStates>(
            builder: (context, favoriteState) {
            return Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: item.productsReponseModel.length,
                    itemBuilder: (ctx, index) => TabHeaderContainerWidget(
                      isEnabled: item.productsReponseModel[index].isEnabled,
                      isSelected: true,
                      title: item
                          .productsReponseModel[index].subCategoryModel.enName,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: item.productsReponseModel.length,
                      itemBuilder: (ctx, productIndex) {
                        return item.productsReponseModel[productIndex].isEnabled
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.productsReponseModel[productIndex]
                                        .subCategoryModel.enName,
                                    style: FontStyle.size22Black600,
                                  ),
                                  const SizedBox(height: 15),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      mainAxisExtent: 190,
                                    ),
                                    itemBuilder: (ctx, index) =>
                                        ProductGridViewItemWidget(
                                      favorite: favoriteState.favoriteProducts,
                                      branchProductModel: item
                                          .productsReponseModel[productIndex]
                                          .branchProducts[index],
                                      branchCategoryId:
                                          widget.branchCategoryModel.id,
                                    ),
                                    itemCount: item
                                        .productsReponseModel[productIndex]
                                        .branchProducts
                                        .length,
                                  ),
                                  const SizedBox(height: 20)
                                ],
                              )
                            : null;
                      }),
                ),
              ],
            );
          });
  }
}
