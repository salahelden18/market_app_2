import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/show_modal_sheet.dart';
import '../../../../home/presentation/views/widgets/address_sheet_widget.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../address/presentation/model_views/address_cubit.dart';

class OrderAddressSection extends StatelessWidget {
  const OrderAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.watch<AddressCubit>();
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        showModalSheet(
          context,
          const AddressSheetWidget(),
        );
      },
      child: Row(
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
          const SizedBox(width: 5),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
