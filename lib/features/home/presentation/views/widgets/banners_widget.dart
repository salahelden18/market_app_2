import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/banner_item.dart';
import '../../view_models/banners/banners_cubit.dart';
import '../../view_models/banners/banners_states.dart';

class BannersWidget extends StatelessWidget {
  const BannersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersStates>(
      builder: (ctx, state) {
        if (state is BannersSuccessState) {
          return CarouselSlider.builder(
            itemCount: state.banners.length,
            itemBuilder: (ctx, index, page) => BannerItem(
              model: state.banners[index],
            ),
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayCurve: Curves.decelerate,
              enlargeFactor: .28,
              autoPlayInterval: const Duration(seconds: 5),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
