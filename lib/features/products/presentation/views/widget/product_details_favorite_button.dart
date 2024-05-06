import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/core/widget/loading_widget.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import 'package:market_app_2/features/favorite/data/models/favorite_model.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_states.dart';

class ProductDetailsFavoriteButton extends StatefulWidget {
  const ProductDetailsFavoriteButton({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailsFavoriteButton> createState() =>
      _ProductDetailsFavoriteButtonState();
}

class _ProductDetailsFavoriteButtonState
    extends State<ProductDetailsFavoriteButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit, FavoriteStates>(
        listener: (context, state) {},
        builder: (context, state) {
          bool isProductInFavorite =
              getProductFavId(state.favoriteProducts) == null ? false : true;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                final auth = context.read<AutoAuthenticationCubit>();
                if (auth.state.authenticationState !=
                    AuthenticationStates.authenticated) {
                  showToast(context: context, msg: 'Please login first');
                } else {
                  setState(() {
                    isLoading = true;
                    print(">>>>> $isLoading");
                  });

                  if (isProductInFavorite) {
                    await context.read<FavoritesCubit>().deleteFromFavorites(
                        getProductFavId(state.favoriteProducts)!);
                  } else {
                    await context
                        .read<FavoritesCubit>()
                        .addToFavorites(widget.productId);
                  }

                  setState(() {
                    isLoading = false;
                    print(">>>>> $isLoading");
                  });
                }
              },
              child: isLoading
                  ? const SizedBox( 
                      height: 28, width: 28, child: LoadingWidget())
                  : Icon(
                      color: AppColors.primaryColor,
                      isProductInFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      size: 28,
                    ),
            ),
          );
        });
  }

  String? getProductFavId(List<FavoriteModel> favs) {
    for (var f in favs) {
      if (widget.productId == f.product.id) {
        return f.id;
      }
    }
    return null;
  }
}
