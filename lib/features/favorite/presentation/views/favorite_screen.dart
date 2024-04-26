import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/widget/not_authenticated_widget.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import '../../../authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AutoAuthenticationCubit>();
    return auth.state.authenticationState == AuthenticationStates.authenticated
        ? Center(
            child: Text('Favorites'),
          )
        : const NotAuthenticatedWidget();
  }
}
