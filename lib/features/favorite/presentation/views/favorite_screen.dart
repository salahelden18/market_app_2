import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/font_style.dart';
import 'package:market_app_2/core/widget/loading_widget.dart';
import 'package:market_app_2/core/widget/not_authenticated_widget.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_cubit.dart';
import 'package:market_app_2/features/favorite/presentation/model_views/favorites_states.dart';
import 'package:market_app_2/features/favorite/presentation/views/widgets/favorite_item_widget.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AutoAuthenticationCubit>();

    return auth.state.authenticationState == AuthenticationStates.authenticated
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Favorites'),
            ),
            body: BlocBuilder<FavoritesCubit, FavoriteStates>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const LoadingWidget();
                } else if (state.favoriteProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'You do\'t have any products in the favorite',
                      style: FontStyle.size22Black600,
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemBuilder: (context, index) => FavoriteItemWidget(
                      favoriteModel: state.favoriteProducts[index],
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: state.favoriteProducts.length,
                  );
                }
              },
            ),
          )
        : const NotAuthenticatedWidget();
  }
}
