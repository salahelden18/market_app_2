import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/address/presentation/model_views/add_edit_address/add_edit_address_cubit.dart';
import 'package:market_app_2/features/address/presentation/model_views/address_common_cubit/address_common_cubit.dart';
import 'package:market_app_2/features/address/presentation/views/add_address_screen.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/forgot_password/forgot_password_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/verifiy/verify_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/views/authentication_screen.dart';
import 'package:market_app_2/features/authentication/presentation/views/forgot_password_screen.dart';
import 'package:market_app_2/features/authentication/presentation/views/otp_screen.dart';
import 'package:market_app_2/features/basket/presentation/views/basket_screen.dart';
import 'package:market_app_2/features/home/presentation/views/home_screen.dart';
import 'package:market_app_2/features/order/presentation/view_models/order_history_cubit.dart';
import 'package:market_app_2/features/order/presentation/view_models/orders/add_order_cubit.dart';
import 'package:market_app_2/features/order/presentation/views/order_screen.dart';
import 'package:market_app_2/features/products/presentation/view_model/products_cubit/products_cubit.dart';
import 'package:market_app_2/features/products/presentation/views/product_details_screen.dart';
import 'package:market_app_2/features/products/presentation/views/products_screen.dart';
import 'package:market_app_2/features/profile/presentation/view/edit_profile_screen.dart';
import 'package:market_app_2/features/search/data/presentation/model_view/cubit/search_cubit.dart';
import 'package:market_app_2/features/search/data/presentation/view/search_screen.dart';
import 'package:market_app_2/loading_data_screen.dart';
import 'package:market_app_2/not_found_screen.dart';
import 'package:market_app_2/service_locator.dart';

import '../../features/order/presentation/view_models/order_details_cubit.dart/order_details_cubit.dart';
import '../../features/order/presentation/views/order_tracking_screen.dart';
import '../../features/order/presentation/views/orders_history_screen.dart';

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

    case AddAddresssScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => MultiBlocProvider(providers: [
          BlocProvider(create: (ctx) => AddressCommonCubit(sl())),
          BlocProvider(create: (ctx) => AddEditAddressCubit(sl())),
        ], child: const AddAddresssScreen()),
        settings: settings,
      );
    case BasketScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => const BasketScreen(),
        settings: settings,
      );
    case OrderScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
            create: (ctx) => AddOrderCubit(sl()), child: const OrderScreen()),
        settings: settings,
      );
    case OrdersHistoryScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
            create: (ctx) => OrderHistoryCubit(sl()),
            child: const OrdersHistoryScreen()),
        settings: settings,
      );
    case OrderTrackingScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
            create: (ctx) => OrderDetailsCubit(sl()),
            child: const OrderTrackingScreen()),
        settings: settings,
      );
    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
            create: (ctx) => ForgotPasswordCubit(sl()),
            child: const ForgotPasswordScreen()),
        settings: settings,
      );
    case EditProfileScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => EditProfileScreen(),
        settings: settings,
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (ctx) => BlocProvider(
          create: (context) => SearchCubit(),
          child: const SearchScreen(),
        ),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (ctx) => const NotFoundScreen(),
      );
  }
}
