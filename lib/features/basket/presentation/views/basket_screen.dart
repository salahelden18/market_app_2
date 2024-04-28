import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/button_bottom_navigation_widget.dart';
import '../../../../core/style/font_style.dart';
import '../../../../core/widget/loading_widget.dart';
import '../model_views/basket_cubit.dart';
import 'widgets/basket_item_widget.dart';
import '../../../../core/widget/not_authenticated_widget.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});
  static const String routeName = '/basket-screen';

  @override
  Widget build(BuildContext context) {
    final basketState = context.watch<BasketCubit>();
    final auth = context.watch<AutoAuthenticationCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        actions: [
          if (basketState.state.basket != null)
            IconButton(
              onPressed: () async {
                //  TODO show alert dialog to indicate to the user if he is sure about deleting the item
                if (basketState.state.basket != null) {
                  await context
                      .read<BasketCubit>()
                      .clearBasket(basketState.state.basket!.id);
                }
              },
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      bottomNavigationBar: const ButtonBottomNavigationBar(),
      body: auth.state.authenticationState == AuthenticationStates.authenticated
          ? Builder(
              builder: (context) {
                if (basketState.state.isFirstLoading) {
                  return const LoadingWidget();
                } else {
                  if (basketState.state.basket == null ||
                      (basketState.state.basket != null &&
                          basketState.state.basket!.basketProducts.isEmpty)) {
                    return const Center(
                      child: Text(
                        'Your Basket is Empty',
                        textAlign: TextAlign.center,
                        style: FontStyle.size22Black600,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: basketState.state.basket!.basketProducts.length,
                    itemBuilder: (context, index) => BasketItemWidget(
                      basketProductModel:
                          basketState.state.basket!.basketProducts[index],
                    ),
                  );
                }
              },
            )
          : const NotAuthenticatedWidget(),
    );
  }
}
