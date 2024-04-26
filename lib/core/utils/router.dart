import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/verifiy/verify_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/views/authentication_screen.dart';
import 'package:market_app_2/features/authentication/presentation/views/otp_screen.dart';
import 'package:market_app_2/features/home/presentation/views/home_screen.dart';
import 'package:market_app_2/features/products/presentation/view_model/products_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/product_details_screen.dart';
import 'package:market_app_2/features/products/presentation/views/products_screen.dart';
import 'package:market_app_2/loading_data_screen.dart';
import 'package:market_app_2/not_found_screen.dart';
import 'package:market_app_2/service_locator.dart';

Route<dynamic> generateRouter(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const HomeScreen(),
        settings: settings,
      );
    case LoadingDataScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const LoadingDataScreen(),
        settings: settings,
      );
    case AuthenticationScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const AuthenticationScreen(),
        settings: settings,
      );
    case OtpScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
            create: (ctx) => VerifyCubit(sl(), sl()), child: const OtpScreen()),
        settings: settings,
      );
    case ProductsScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
            create: (ctx) => ProductsCubit(sl()),
            child: const ProductsScreen()),
        settings: settings,
      );
    case ProductDetailsScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const ProductDetailsScreen(),
        settings: settings,
      );
    default:
      return MaterialPageRoute(
        builder: (ctx) => const NotFoundScreen(),
      );
  }
}
