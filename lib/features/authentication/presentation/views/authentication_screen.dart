import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/style/font_style.dart';
import '../../../../core/utils/dialog_manager_overlay.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../../core/widget/custome_text_form_field.dart';
import '../../../../core/widget/filled_button_widget.dart';
import '../../data/models/authentication_request_model.dart';
import '../model_views/auto_authenticate/auto_authentication_cubit.dart';
import '../model_views/login/login_cubit.dart';
import '../model_views/login/login_states.dart';
import '../model_views/signup/signup_cubit.dart';
import '../model_views/signup/signup_states.dart';
import 'otp_screen.dart';
import 'widgets/authentication/authentication_image.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  static const String routeName = '/authentication-scrren';

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailAddresssController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailAddresssController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                const SizedBox(height: 20),
                AuhtenticationImageWidget(isLogin: isLogin),
                const SizedBox(height: 10),
                Text(
                  isLogin ? 'Login' : "Register",
                  style: FontStyle.size22Black600,
                ),
                const SizedBox(height: 5),
                Text('Please ${isLogin ? 'Sign in' : 'register'} to continue'),
                const SizedBox(height: 20),
                if (!isLogin)
                  CustomTextFormField(
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Full name is required';
                      }
                      return null;
                    },
                    controller: fullNameController,
                    label: 'Full Name',
                  ),
                if (!isLogin) const SizedBox(height: 10),
                CustomTextFormField(
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'email address is required';
                    } else if (!value.contains('@')) {
                      return 'please enter valid email address';
                    }
                    return null;
                  },
                  controller: emailAddresssController,
                  label: 'Email Address',
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  prefixIcon: Icons.lock_outline_rounded,
                  isPass: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is required';
                    } else if (value.length < 9) {
                      return 'password should be at least 9 characters';
                    }
                    return null;
                  },
                  controller: passwordController,
                  label: 'Password',
                ),
                if (!isLogin) const SizedBox(height: 10),
                if (!isLogin)
                  CustomTextFormField(
                    prefixIcon: Icons.lock_outline_rounded,
                    validator: (value) {
                      if (value != passwordController.text) {
                        return 'password is incorrect';
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                    isPass: true,
                    label: 'Confirm Password',
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: isLogin
                              ? 'Don\'t have an account? '
                              : 'Already have an account? ',
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.black),
                        ),
                        TextSpan(
                            text: isLogin ? 'Register' : 'Sign in',
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.primaryColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  isLogin = !isLogin;
                                });
                              }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MultiBlocListener(
                  listeners: [
                    BlocListener<LoginCubit, LoginStates>(
                      listener: (context, state) async {
                        if (state is LoginLoadingState) {
                          DialogManagerOverlay.showDialogWithMessage(context);
                        } else if (state is LoginFailureState) {
                          DialogManagerOverlay.closeDialog();
                          showToast(context: context, msg: state.errorMessage);
                        } else if (state is LoginSuccesstate) {
                          // if the token exist authenticate the user and finish the process
                          if (state.loginModel.token != null) {
                            // if the token is null show the message and navigate to the otp screen
                            await context
                                .read<AutoAuthenticationCubit>()
                                .authenticateUser();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } else {
                            showToast(
                                context: context,
                                msg: state.loginModel.message!,
                                messageType: MessageType.success);
                            // navigate to the otp screen
                            Navigator.of(context).pushNamed(OtpScreen.routeName,
                                arguments: state.loginModel.userId);
                          }

                          DialogManagerOverlay.closeDialog();
                        } else {
                          DialogManagerOverlay.closeDialog();
                        }
                      },
                    ),
                    BlocListener<SignupCubit, SignupStates>(
                      listener: (context, state) {
                        if (state is SigupLoadingState) {
                          DialogManagerOverlay.showDialogWithMessage(context);
                        } else if (state is SignupFailureState) {
                          DialogManagerOverlay.closeDialog();
                          showToast(context: context, msg: state.errorMessage);
                        } else if (state is SigupSuccesstate) {
                          DialogManagerOverlay.closeDialog();
                          showToast(
                            context: context,
                            msg: state.signupModel.message,
                            messageType: MessageType.success,
                          );
                          // navigate to otp screen
                          Navigator.of(context).pushNamed(OtpScreen.routeName,
                              arguments: state.signupModel.userId);
                        }
                      },
                    ),
                  ],
                  child: FilledButtonWidget(
                    onPress: onTap,
                    widget: Text(isLogin ? 'Sign in' : 'Register'),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text('Forget Password?'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onTap() async {
    var isValid = _formKey.currentState!.validate();

    if (isValid) {
      // constructing the model
      var auth = AuthenticationRequestModel(
        email: emailAddresssController.text.trim(),
        fullName: fullNameController.text == ''
            ? null
            : fullNameController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (isLogin) {
        await context.read<LoginCubit>().login(auth);
      } else {
        await context.read<SignupCubit>().signup(auth);
      }
    }
  }
}
