import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../address/presentation/model_views/address_cubit.dart';

class OrderAddressSection extends StatelessWidget {
  const OrderAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.watch<AddressCubit>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(addressCubit.state.selectedAddress?.fullAddress ?? ''),
        ),
      ],
    );
  }
}
