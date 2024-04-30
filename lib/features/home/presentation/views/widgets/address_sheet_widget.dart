import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/address/presentation/views/add_address_screen.dart';
import '../../../../../core/style/font_style.dart';
import '../../../../address/presentation/model_views/address_cubit.dart';
import 'address_item_widget.dart';

class AddressSheetWidget extends StatelessWidget {
  const AddressSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = context.watch<AddressCubit>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Addresses',
                style: FontStyle.size22Black600.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddAddresssScreen.routeName);
                },
                child: const Text('Add New Address'),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: addresses.state.addresses.length,
              itemBuilder: (context, index) {
                final address = addresses.state.addresses[index];

                return AddressItemWidget(
                  addressModel: address,
                  isSelected: address.id == addresses.state.selectedAddress?.id,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
