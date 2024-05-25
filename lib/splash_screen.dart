import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/widget/splash_loading_screen.dart';
import 'loading_data_screen.dart';
import 'features/home/presentation/view_models/location_and_gps_cubit/location_and_gps_cubit.dart';
import 'features/home/presentation/view_models/location_and_gps_cubit/location_and_gps_states.dart';

// here in this screen we will ask the user to give us permission for the location and checking for the service

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationAndGpsCubit>().checkingServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LocationAndGpsCubit, LocationAndGPSState>(
        listener: (context, state) {
          if (state.currentLocation != null) {
            Navigator.of(context)
                .pushReplacementNamed(LoadingDataScreen.routeName);
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const SplashLoadingScreen();
          } else if (state.hasError) {
            return Center(
              child: Text(state.errorMessage ?? 'error'),
            );
          } else if (!state.isServiceEnabled || !state.hasPermission) {
            return const Center(
              child: Text(
                  'Please Enable the service location and enable the permissions'),
            );
          } // else we will navigate to the home screen
          return const SizedBox();
        },
      ),
    );
  }
}
