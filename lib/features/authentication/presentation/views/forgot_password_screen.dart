import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/utils/dialog_manager_overlay.dart';
import 'package:market_app_2/core/utils/show_toast.dart';
import 'package:market_app_2/core/widget/custome_text_form_field.dart';
import 'package:market_app_2/features/authentication/data/models/forgot_password_model.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/forgot_password/forgot_password_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/forgot_password/forgot_password_states.dart';
import 'package:market_app_2/features/authentication/presentation/views/otp_screen.dart';
import 'package:market_app_2/features/authentication/presentation/views/widgets/header_widget.dart';

import '../../../../core/widget/filled_button_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  static const String routeName = "/forgot-password-screen";

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const HeaderWidget(
                    message: 'Please enter your email address to get OTP',
                    title: 'Forgot Password',
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter value';
                      } else if (!value.contains('@')) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            BlocListener<ForgotPasswordCubit, ForgotPasswordStates>(
              listener: (context, state) {
                if (state is ForgotPasswordLoadingState) {
                  DialogManagerOverlay.showDialogWithMessage(context);
                } else if (state is ForgotPasswordFailureState) {
                  DialogManagerOverlay.closeDialog();
                  showToast(context: context, msg: state.errorMessage);
                } else if (state is ForgotPasswordSuccessState) {
                  DialogManagerOverlay.closeDialog();
                  showToast(
                      context: context,
                      msg: state.signupModel.message,
                      messageType: MessageType.success);
                  Navigator.of(context).pushNamed(OtpScreen.routeName);
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FilledButtonWidget(
                  onPress: () {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      context.read<ForgotPasswordCubit>().forgotPassword(
                            ForgotPasswordModel(_emailController.text),
                          );
                    }
                  },
                  widget: const Text('Confirm'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
