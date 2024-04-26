import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/font_style.dart';
import 'filled_button_widget.dart';
import '../../features/authentication/presentation/views/authentication_screen.dart';

class NotAuthenticatedWidget extends StatelessWidget {
  const NotAuthenticatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login to continue',
            style: FontStyle.size22Black600,
          ),
          const SizedBox(height: 10),
          const Text('To be able to use this feature you should login first'),
          const SizedBox(height: 20),
          FilledButtonWidget(
            onPress: () {
              Navigator.of(context).pushNamed(AuthenticationScreen.routeName);
            },
            widget: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
