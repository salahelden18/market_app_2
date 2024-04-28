import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/address/presentation/model_views/address_cubit.dart';
import 'package:market_app_2/features/address/presentation/views/add_address_screen.dart';
import 'package:market_app_2/features/home/presentation/view_models/location_and_gps_cubit/location_and_gps_cubit.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/font_style.dart';

class HomeAddressContainer extends StatelessWidget {
  const HomeAddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final address = context.watch<AddressCubit>();
    final location = context.read<LocationAndGpsCubit>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AddAddresssScreen.routeName);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style:
                FontStyle.size16AndLightGrey.copyWith(color: AppColors.black),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.primaryColor,
              ),
              const SizedBox(width: 5),
              Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    getAddressText(address, location),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              const SizedBox(width: 5),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String getAddressText(AddressCubit address, LocationAndGpsCubit location) {
    // if there is no address for the user we will display the current location of the user
    if (address.state.selectedAddress == null) {
      return '${location.state.currentLocation?.country}, ${location.state.currentLocation?.city}, ${location.state.currentLocation?.area}, ${location.state.currentLocation?.neighborhood}';
    } else {
      return '${address.state.selectedAddress?.fullAddress}';
    }
  }
}
