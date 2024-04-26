import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/font_style.dart';
import '../../../../core/utils/dialog_manager_overlay.dart';
import '../../../../core/widget/loading_widget.dart';
import '../model_views/basket_cubit.dart';
import '../model_views/basket_states.dart';
import 'widgets/basket_item_widget.dart';
import '../../../../core/widget/not_authenticated_widget.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AutoAuthenticationCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
      ),
      body: auth.state.authenticationState == AuthenticationStates.authenticated
          ? BlocConsumer<BasketCubit, BasketStates>(
              listener: (context, state) {
                if (state.isLoading) {
                  DialogManagerOverlay.showDialogWithMessage(context);
                } else {
                  DialogManagerOverlay.closeDialog();
                }
              },
              builder: (context, state) {
                if (state.isFirstLoading) {
                  return const LoadingWidget();
                } else {
                  if (state.basket == null ||
                      (state.basket != null &&
                          state.basket!.basketProducts.isEmpty)) {
                    return const Center(
                      child: Text(
                        'Your Basket is Empty',
                        textAlign: TextAlign.center,
                        style: FontStyle.size22Black600,
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 15),
                    itemCount: state.basket!.basketProducts.length,
                    itemBuilder: (context, index) => BasketItemWidget(
                      basketProductModel: state.basket!.basketProducts[index],
                    ),
                  );
                }
              },
            )
          : const NotAuthenticatedWidget(),
    );
  }
}
