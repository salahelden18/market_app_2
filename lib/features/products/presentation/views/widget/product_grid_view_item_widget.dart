import 'package:flutter/material.dart';
import '../../../../../core/style/font_style.dart';
import '../../../data/models/branch_product_model.dart';

class ProductGridViewItemWidget extends StatelessWidget {
  const ProductGridViewItemWidget(
      {super.key, required this.branchProductModel});
  final BranchProductModel branchProductModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 2,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            width: double.infinity,
            child: Image.network(
              branchProductModel.product!.images[0],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            branchProductModel.product!.enName,
            style: FontStyle.size18Normal,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(branchProductModel.price.toString()),
        ],
      ),
    );
  }
}
