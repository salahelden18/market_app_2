import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/features/basket/presentation/model_views/basket_cubit.dart';
import 'package:market_app_2/features/order/presentation/view_models/payment/payment_method_cubit.dart';
import 'core/style/theme.dart';
import 'core/utils/router.dart';
import 'features/address/presentation/model_views/address_cubit.dart';
import 'features/authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import 'features/authentication/presentation/model_views/login/login_cubit.dart';
import 'features/authentication/presentation/model_views/signup/signup_cubit.dart';
import 'features/favorite/presentation/model_views/favorites_cubit.dart';
import 'features/home/presentation/view_models/banners/banners_cubit.dart';
import 'features/home/presentation/view_models/bottm_nav_bar_cubit/bottom_nav_bar_cubit.dart';
import 'features/home/presentation/view_models/branch/branch_cubit.dart';
import 'features/home/presentation/view_models/categories/categories_cubit.dart';
import 'features/home/presentation/view_models/location_and_gps_cubit/location_and_gps_cubit.dart';
import 'splash_screen.dart';
import 'service_locator.dart' as di;

import 'custom_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  Bloc.observer = CustomBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (ctx) =>
                AutoAuthenticationCubit(di.sl())..authenticateUser()),
        BlocProvider(create: (ctx) => BranchCubit(di.sl())),
        BlocProvider(create: (ctx) => AddressCubit(di.sl(), di.sl())),
        BlocProvider(create: (ctx) => LocationAndGpsCubit(di.sl())),
        BlocProvider(create: (ctx) => BannersCubit(di.sl())),
        BlocProvider(create: (ctx) => BottomNavBarCubit()),
        BlocProvider(create: (ctx) => CategoriesCubit(di.sl())),
        BlocProvider(create: (ctx) => LoginCubit(di.sl(), di.sl())),
        BlocProvider(create: (ctx) => SignupCubit(di.sl())),
        BlocProvider(create: (ctx) => FavoritesCubit(di.sl())),
        BlocProvider(create: (ctx) => BasketCubit(di.sl())),
        BlocProvider(create: (ctx) => PaymentMethodCubit(di.sl())),
      ],
      child: MaterialApp(
        title: 'Market App',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        onGenerateRoute: generateRouter,
      ),
    );
  }
}
