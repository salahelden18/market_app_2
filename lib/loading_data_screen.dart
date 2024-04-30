import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import 'features/basket/presentation/model_views/basket_cubit.dart';
import 'features/favorite/presentation/model_views/favorites_cubit.dart';
import 'features/home/presentation/views/home_screen.dart';
import 'features/order/presentation/view_models/active_order/current_active_orders_cubit.dart';
import 'features/profile/presentation/model_views/profile_cubit.dart';

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
            print('>>>>>>>>> ${snapshot.error}');
            print('>>>>>>>>> $snapshot');
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

  Future getData(BuildContext context) async {
    final location = context.read<LocationAndGpsCubit>().state;

    // authenticate the user
    await context.read<AutoAuthenticationCubit>().authenticateUser();
    if (context.mounted) {
      final auth = context.read<AutoAuthenticationCubit>();

      // getting the data that requires authentication
      if (auth.state.authenticationState ==
          AuthenticationStates.authenticated) {
        await Future.wait([
          context.read<AddressCubit>().getAddresses(),
          context.read<FavoritesCubit>().getFavorites(),
          context.read<ProfileCubit>().getProfile(),
          context.read<CurrentActiveOrderCubit>().getActiveOrders(),
        ]);
      }

      if (context.mounted) {
        final address = context.read<AddressCubit>().state;
        // get the data that does not require any authentication
        await Future.wait([
          context.read<BannersCubit>().getBanners(),
          context.read<BranchCubit>().getBranch(
                address.selectedAddress?.lat ?? location.currentLocation!.lat,
                address.selectedAddress?.lng ?? location.currentLocation!.lng,
                address.selectedAddress?.subDistrictId,
              ),
        ]);

        // getting the basket of the branch is not null and the user is authenticated
        if (context.mounted &&
            auth.state.authenticationState ==
                AuthenticationStates.authenticated &&
            context.read<BranchCubit>().state.branchModel?.id != null) {
          await context
              .read<BasketCubit>()
              .getBasket(context.read<BranchCubit>().state.branchModel!.id);
        }

        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        }
      }
    }
  }
}
