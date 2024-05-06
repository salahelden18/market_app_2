import 'package:flutter/material.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/features/home/data/models/branch_category_model.dart';
import '../../../../products/presentation/views/products_screen.dart';
import '../../../data/models/22.dart';

class CategoryListItemWidget extends StatelessWidget {
  const CategoryListItemWidget(
      {super.key, required this.categoryModel, required this.index});
  final BranchCategoryModel categoryModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!categoryModel.isEnabled!) {
          showToast(
              context: context,
              msg: 'This category unavailable',
              messageType: MessageType.error);
        } else {
          Navigator.of(context)
              .pushNamed(ProductsScreen.routeName, arguments: index);
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              // The category image
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(.5)),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image:
                                NetworkImage(categoryModel.category!.imageUrl!),
                            fit: BoxFit.contain,
                          )),
                    ),
                    if (!categoryModel.isEnabled!)
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(.5)),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black26,
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // The category title
              FittedBox(
                child: Text(
                  categoryModel.category!.enName!,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
