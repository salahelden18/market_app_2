import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:market_app_2/features/products/presentation/views/widget/shimmer_loading_widgets/grid_list_view_loading_widget.dart';
import 'package:market_app_2/features/products/presentation/views/widget/shimmer_loading_widgets/tab_header_container_loading_widget.dart';

class TabBarViewItemLoadingWidget extends StatefulWidget {
  const TabBarViewItemLoadingWidget({super.key});

  @override
  State<TabBarViewItemLoadingWidget> createState() =>
      _TabBarViewItemWidgetState();
}

class _TabBarViewItemWidgetState extends State<TabBarViewItemLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        SizedBox(
          height: 40,
          child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: 6,
              itemBuilder: (ctx, index) =>
                  const TabHeaderContainerLoadingWidget()),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: 2,
              itemBuilder: (ctx, productIndex) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabHeaderContainerLoadingWidget(),
                    SizedBox(height: 15),
                    GridListViewLoadingWidget(),
                    SizedBox(height: 20)
                  ],
                );
              }),
        ),
      ],
    );
  }
}
