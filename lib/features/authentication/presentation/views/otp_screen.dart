import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../address/presentation/model_views/address_cubit.dart';
import '../../../basket/presentation/model_views/basket_cubit.dart';
import '../../../favorite/presentation/model_views/favorites_cubit.dart';
import '../../../home/presentation/view_models/branch/branch_cubit.dart';
import '../../../profile/presentation/model_views/profile_cubit.dart';
import 'widgets/header_widget.dart';
import '../../../../core/utils/dialog_manager_overlay.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../../core/widget/filled_button_widget.dart';
import '../../data/models/verify_request_model.dart';
import '../model_views/auto_authenticate/auto_authentication_cubit.dart';
import '../model_views/verifiy/verify_cubit.dart';
import '../model_views/verifiy/verify_state.dart';
import '../../../home/presentation/views/home_screen.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static const String routeName = "/otp-screen";

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';

  @override
  Widget build(BuildContext context) {
    String? userId = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const HeaderWidget(
                    message:
                        'We have sent otp to you email please enter the four digits that you received',
                    title: 'Verification',
                  ),
                  Pinput(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    length: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    onChanged: (value) {
                      setState(() {
                        otp = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            BlocListener<VerifyCubit, VerifyStates>(
              listener: (context, state) async {
                if (state is VerifyLoadingState) {
                  DialogManagerOverlay.showDialogWithMessage(context);
                } else if (state is VerifyFailureState) {
                  DialogManagerOverlay.closeDialog();
                  showToast(context: context, msg: state.errorMessage);
                } else if (state is VerifySuccessState) {
                  final branchId =
                      context.read<BranchCubit>().state.branchModel!.id;
                  await Future.wait([
                    context.read<AutoAuthenticationCubit>().authenticateUser(),
                    context.read<ProfileCubit>().getProfile(),
                    context.read<FavoritesCubit>().getFavorites(),
                    context.read<BasketCubit>().getBasket(branchId),
                    context.read<AddressCubit>().getAddresses(),
                  ]);
                  DialogManagerOverlay.closeDialog();
                  Navigator.of(context).popUntil(
                      (route) => route.settings.name == HomeScreen.routeName);
                } else {
                  DialogManagerOverlay.closeDialog();
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FilledButtonWidget(
                  onPress: otp.length != 4
                      ? null
                      : () {
                          context.read<VerifyCubit>().verify(
                              VerifyRequestModel(otp: otp, userId: userId!));
                        },
                  widget: const Text('Confirm'),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
