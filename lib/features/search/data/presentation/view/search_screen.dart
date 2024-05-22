import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/widget/conditional_builder.dart';
import 'package:market_app_2/core/widget/custome_text_form_field.dart';
import 'package:market_app_2/features/products/presentation/views/widget/shimmer_loading_widgets/grid_list_view_loading_widget.dart';
import 'package:market_app_2/features/search/data/presentation/model_view/cubit/search_cubit.dart';
import 'package:market_app_2/features/search/data/presentation/view/widgets/search_product_item_widget.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search-screen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchCubit = context.watch<SearchCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsetsDirectional.all(10),
            children: [
              // Search section
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: searchController,
                        label: 'Search',
                        onFieldSubmitted: (value) {
                          searchCubit.search(
                            context: context,
                            searchValue: value,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton(
                        onPressed: () {
                          searchCubit.search(
                              context: context,
                              searchValue: searchController.text);
                        },
                        child: const Icon(Icons.search_rounded)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Search Result
              if (state is SearchSuccessState)
                ConditionalBuilder(
                  condition: state.searchResults.isNotEmpty,
                  isTrueWidget: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      mainAxisExtent: 190,
                    ),
                    itemBuilder: (ctx, index) => SearchProductItemWidget(
                      model: state.searchResults[index],
                    ),
                    itemCount: state.searchResults.length,
                  ),
                  isFalseWidget:
                      const Center(child: Text('There is no results')),
                ),
              if (state is SearchErrorState) Center(child: Text(state.message)),
              if (state is SearchLoadingState)
                const GridListViewLoadingWidget(),
            ],
          );
        },
      ),
    );
  }
}
