import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/home/presentation/view_models/categories/categories_cubit.dart';
import 'package:market_app_2/features/home/presentation/view_models/categories/categories_states.dart';
import 'package:market_app_2/features/products/presentation/view_model/products_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/widget/tab_bar_view_item_widget.dart';

import '../../../home/data/models/branch_category_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  static const String routeName = '/products-screen';

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;
  bool isExecuted = false;
  List<BranchCategoryModel> categories = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isExecuted) {
      int initialIndex = ModalRoute.of(context)!.settings.arguments as int;
      // getting the list of the categories
      categories =
          (context.read<CategoriesCubit>().state as CategoriesSuccessState)
              .categories;

      context.read<ProductsCubit>().init(categories);

      tabController = TabController(
          length: categories.length, initialIndex: initialIndex, vsync: this);
      isExecuted = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        bottom: TabBar(
          labelColor: AppColors.fifthColor,
          indicatorColor: AppColors.warningColor,
          unselectedLabelColor: Colors.grey,
          tabAlignment: TabAlignment.start,
          isScrollable: true,
          controller: tabController,
          tabs: List.generate(
            categories.length,
            (index) => Text(categories[index].category.enName),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          categories.length,
          (index) => TabBarViewItemWidget(
            branchCategoryModel: categories[index],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
