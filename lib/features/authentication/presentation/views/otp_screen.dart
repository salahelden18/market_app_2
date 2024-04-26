import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/style/font_style.dart';
import 'package:market_app_2/core/utils/dialog_manager_overlay.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/core/widget/filled_button_widget.dart';
import 'package:market_app_2/features/authentication/data/models/verify_request_model.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/verifiy/verify_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/verifiy/verify_state.dart';
import 'package:market_app_2/features/home/presentation/views/home_screen.dart';
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Verification',
                    style: FontStyle.size22Black600,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      'We have sent otp to you email please enter the four digits that you received'),
                  const SizedBox(height: 30),
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
              listener: (context, state) {
                if (state is VerifyLoadingState) {
                  DialogManagerOverlay.showDialogWithMessage(context);
                } else if (state is VerifyFailureState) {
                  DialogManagerOverlay.closeDialog();
                  showToast(context: context, msg: state.errorMessage);
                } else if (state is VerifySuccessState) {
                  context.read<AutoAuthenticationCubit>().authenticateUser();
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
