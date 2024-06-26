import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/presentation/view_models/categories/categories_states.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/categories_loading_shimmer.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/category_list_item_widget.dart';
import '../../view_models/branch/branch_cubit.dart';
import '../../view_models/categories/categories_cubit.dart';

class CategoriesListWidget extends StatefulWidget {
  const CategoriesListWidget({super.key});

  @override
  State<CategoriesListWidget> createState() => _CategoriesListWidgetState();
}

class _CategoriesListWidgetState extends State<CategoriesListWidget> {
  @override
  void initState() {
    super.initState();
    final branch = context.read<BranchCubit>();
    if (context.read<CategoriesCubit>().state is! CategoriesSuccessState) {
      context
          .read<CategoriesCubit>()
          .getCategories(branch.state.branchModel!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
        builder: (ctx, state) {
      if (state is CategoriesLoadingState) {
        return const CategoriesLoadingShimmer();
      } else if (state is CategoriesSuccessState) {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
            mainAxisExtent: 120,
          ),
          itemBuilder: (context, index) => CategoryListItemWidget(
            index: index,
            categoryModel: state.categories[index],
          ),
          itemCount: state.categories.length,
        );
      } else {
        final errorMessage =
            state is CategoriesFailureState ? state.errorMessage : 'Error';

        return Center(
          child: Text(errorMessage),
        );
      }
    });
  }
}
