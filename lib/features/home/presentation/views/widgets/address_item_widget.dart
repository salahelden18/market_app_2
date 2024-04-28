import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/address/presentation/views/add_address_screen.dart';
import '../../../../address/presentation/model_views/address_cubit.dart';
import '../../../../../core/style/app_colors.dart';
import '../../../../address/data/models/address_model.dart';

class AddressItemWidget extends StatelessWidget {
  const AddressItemWidget({
    super.key,
    required this.addressModel,
    required this.isSelected,
  });
  final AddressModel addressModel;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.read<AddressCubit>().selectAddress(addressModel);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightGray),
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.lightGray),
              ),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.lightGray),
                  color: isSelected ? AppColors.primaryColor : null,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '${addressModel.city?.enName}, ${addressModel.district?.enName}, ${addressModel.subDistrict?.enName}, ${addressModel.fullAddress}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AddAddresssScreen.routeName,
                      arguments: addressModel);
                },
                child: Icon(
                  Icons.edit,
                  color: AppColors.secondColor,
                )),
          ],
        ),
      ),
    );
  }
}
