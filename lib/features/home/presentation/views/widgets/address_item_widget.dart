import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/font_style.dart';
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
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? AppColors.lightPrimaryColor : null,
          border: Border.all(
            color: AppColors.primaryColor,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 23,
              height: 23,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.white.withOpacity(.7)
                    : AppColors.white,
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              // decoration: BoxDecoration(
              //   shape: BoxShape.circle,
              //   border: Border.all(color: AppColors.lightGray),
              // ),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.lightGray),
                  color: isSelected ? AppColors.primaryColor : null,
                ),
              ),
            ),
            const SizedBox(width: 5),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${addressModel.city?.enName}',
                    style: FontStyle.size18Normal.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    '${addressModel.district?.enName}, ${addressModel.subDistrict?.enName}, ${addressModel.fullAddress}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AddAddresssScreen.routeName,
                      arguments: addressModel);
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.amber,
                )),
          ],
        ),
      ),
    );
  }
}
