import 'package:flutter/material.dart';
import '../../../../products/presentation/views/products_screen.dart';
import '../../../data/models/branch_category_model.dart';

class CategoryListItemWidget extends StatelessWidget {
  const CategoryListItemWidget(
      {super.key, required this.categoryModel, required this.index});
  final BranchCategoryModel categoryModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductsScreen.routeName, arguments: index);
      },
      child: Column(
        children: [
          // The category image
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.5)),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(categoryModel.category.imageUrl),
                    fit: BoxFit.contain,
                  )),
            ),
          ),
          const SizedBox(height: 10),
          // The category title
          FittedBox(
            child: Text(
              categoryModel.category.enName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
