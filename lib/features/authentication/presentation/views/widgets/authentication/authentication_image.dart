import 'package:flutter/material.dart';
import 'package:market_app_2/core/constants/image_constants.dart';

class AuhtenticationImageWidget extends StatelessWidget {
  const AuhtenticationImageWidget({super.key, required this.isLogin});
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Image.asset(
      height: size.height * 0.35,
      isLogin ? ImageConstants.signinImage : ImageConstants.signupImage,
    );
  }
}
