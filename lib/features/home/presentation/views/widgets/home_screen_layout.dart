import 'package:flutter/material.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/active_order_section.dart';
import 'categories_list_widget.dart';
import 'category_section.dart';
import 'banners_widget.dart';
import 'home_header_section.dart';

class HomeScreenLayout extends StatelessWidget {
  const HomeScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 1) {
            return children[index];
          }
          return Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: children[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 30),
        itemCount: children.length,
      ),
    );
  }

  final List<Widget> children = const [
    HomeHeaderSection(),
    BannersWidget(),
    ActiveOrderSection(),
    CategorySection(
      title: 'Categories',
      widget: CategoriesListWidget(),
    ),
    SizedBox(height: 50),
  ];
}
