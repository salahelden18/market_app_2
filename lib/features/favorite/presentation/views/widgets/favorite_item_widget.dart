import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/widget/loading_widget.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import '../../../../../core/style/font_style.dart';
import '../../../data/models/favorite_model.dart';

class FavoriteItemWidget extends StatefulWidget {
  const FavoriteItemWidget({super.key, required this.favoriteModel});
  final FavoriteModel favoriteModel;

  @override
  State<FavoriteItemWidget> createState() => _FavoriteItemWidgetState();
}

class _FavoriteItemWidgetState extends State<FavoriteItemWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            child: Image.network(
              widget.favoriteModel.product.images[0],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.favoriteModel.product.enName,
                    style: FontStyle.size22Black600,
                  ),
                  if (widget.favoriteModel.product.enDescription != null)
                    const SizedBox(height: 10),
                  if (widget.favoriteModel.product.enDescription != null)
                    Text(widget.favoriteModel.product.enDescription!),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                await context
                    .read<FavoritesCubit>()
                    .deleteFromFavorites(widget.favoriteModel.id);
                setState(() {
                  isLoading = false;
                });
              },
              child: isLoading
                  ? const LoadingWidget()
                  : const Icon(
                      Icons.delete_outline,
                      color: AppColors.errorColor,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
