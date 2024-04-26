import 'package:flutter/material.dart';

import '../../../../../core/style/app_colors.dart';
import '../../../data/models/banners_model.dart';

class BannerItem extends StatelessWidget {
  const BannerItem({
    super.key,
    this.model,
  });
  final BannerModel? model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Todo
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(.1),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(model!.imageUrl ?? ''),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
