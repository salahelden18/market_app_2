import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import 'package:market_app_2/features/home/presentation/views/home_screen.dart';
import 'package:market_app_2/features/order/presentation/view_models/active_order/current_active_orders_cubit.dart';
import 'package:market_app_2/features/profile/presentation/model_views/profile_cubit.dart';

import 'core/widget/loading_widget.dart';
import 'features/address/presentation/model_views/address_cubit.dart';
import 'features/home/presentation/view_models/banners/banners_cubit.dart';
import 'features/home/presentation/view_models/branch/branch_cubit.dart';
import 'features/home/presentation/view_models/location_and_gps_cubit/location_and_gps_cubit.dart';

class LoadingDataScreen extends StatelessWidget {
  const LoadingDataScreen({super.key});
  static const String routeName = "/loading-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(context),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }

  // TODO will be formated later
  Future getData(BuildContext context) async {
    final location = context.read<LocationAndGpsCubit>().state;

    // here the user is authenticated
    await Future.wait([
      context.read<AddressCubit>().getAddresses(),
      context.read<FavoritesCubit>().getFavorites(),
      context.read<ProfileCubit>().getProfile(),
    ]);

    if (context.mounted) {
      final address = context.read<AddressCubit>().state;

      await Future.wait([
        context.read<BannersCubit>().getBanners(),
        context.read<BranchCubit>().getBranch(
              address.selectedAddress?.lat ?? location.currentLocation!.lat,
              address.selectedAddress?.lng ?? location.currentLocation!.lng,
              address.selectedAddress?.subDistrictId,
            ),
        context.read<CurrentActiveOrderCubit>().getActiveOrders(),
      ]);

      // gettinn the basket data
      await context
          .read<BasketCubit>()
          .getBasket(context.read<BranchCubit>().state.branchModel!.id);
    }
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }
}
