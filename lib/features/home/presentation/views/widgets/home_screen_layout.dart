import 'package:flutter/material.dart';
import 'categories_list_widget.dart';
import 'category_section.dart';
import 'banners_widget.dart';
import 'home_header_section.dart';

class HomeScreenLayout extends StatelessWidget {
  const HomeScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        padding: const EdgeInsets.all(10),
        children: const [
          SizedBox(height: 30),
          HomeHeaderSection(),
          SizedBox(height: 30),
          BannersWidget(),
          SizedBox(height: 20),
          // TODO add active orders here
          CategorySection(
            title: 'Categories',
            widget: CategoriesListWidget(),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
