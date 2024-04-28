import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/show_modal_sheet.dart';
import '../../../../../core/utils/show_toast.dart';
import '../../../../address/presentation/model_views/address_cubit.dart';
import '../../../../address/presentation/views/add_address_screen.dart';
import '../../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import '../../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import '../../view_models/location_and_gps_cubit/location_and_gps_cubit.dart';
import 'address_sheet_widget.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../../core/style/font_style.dart';

class HomeAddressContainer extends StatelessWidget {
  const HomeAddressContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final address = context.watch<AddressCubit>();
    final location = context.read<LocationAndGpsCubit>();

    return GestureDetector(
      onTap: () async {
        final auth = context.read<AutoAuthenticationCubit>();
        final address = context.read<AddressCubit>();

        if (auth.state.authenticationState ==
            AuthenticationStates.authenticated) {
          if (address.state.addresses.isEmpty) {
            Navigator.of(context).pushNamed(AddAddresssScreen.routeName);
          } else {
            await showModalSheet(
              context,
              const AddressSheetWidget(),
            );
          }
        } else {
          showToast(
            context: context,
            msg: 'Please login first',
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Location',
            style: FontStyle.size16AndLightGrey,
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
                fit: FlexFit.loose,
                child: Text(
                  getAddressText(address, location),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
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
