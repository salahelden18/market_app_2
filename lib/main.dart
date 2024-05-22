import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/products/presentation/view_model/products_cubit/products_cubit.dart';
import 'features/profile/presentation/model_views/profile_cubit.dart';
import 'features/basket/presentation/model_views/basket_cubit.dart';
import 'features/order/presentation/view_models/payment/payment_method_cubit.dart';
import 'firebase_cloud_messaging.dart';
import 'firebase_options.dart';
import 'core/services/navigator_observer.dart';
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
import 'features/order/presentation/view_models/active_order/current_active_orders_cubit.dart';
import 'splash_screen.dart';
import 'service_locator.dart' as di;

import 'custom_bloc_observer.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Intialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Configure Firebase Cloud Messaging
  await configureFirebaseMessaging();
  await requestNotificationPermissions();
  await handleFCMToken();

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
        BlocProvider(create: (ctx) => AutoAuthenticationCubit(di.sl())),
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
        BlocProvider(create: (ctx) => CurrentActiveOrderCubit(di.sl())),
        BlocProvider(create: (ctx) => ProfileCubit(di.sl())),
        BlocProvider(create: (ctx) => ProductsCubit(di.sl())),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [MyRouteObserver()],
        title: 'Market App',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        onGenerateRoute: generateRouter,
      ),
    );
  }
}
