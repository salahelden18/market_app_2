import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/widget/custome_text_form_field.dart';
import 'package:market_app_2/core/widget/filled_button_widget.dart';
import 'package:market_app_2/core/widget/loading_widget.dart';
import 'package:market_app_2/features/profile/presentation/model_views/profile_cubit.dart';
import 'package:market_app_2/features/profile/presentation/model_views/profile_states.dart';

class EditProfileScreen extends StatelessWidget {
  static const String routeName = "edit-profile-screen";
  EditProfileScreen({super.key});

  final fullNameController = TextEditingController();
  final phoneNubmerController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final profileCubit = context.watch<ProfileCubit>();
    final currentState = profileCubit.state;
    if (currentState is ProfileSuccessState) {
      fullNameController.text = currentState.userProfileModel!.fullName;
      phoneNubmerController.text = currentState.userProfileModel!.phoneNumber!;

      return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsetsDirectional.all(15),
            children: [
              const Text(
                'Full name',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: fullNameController,
                label: currentState.userProfileModel!.fullName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Full name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              const Text(
                'Phone nubmer',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: phoneNubmerController,
                label: currentState.userProfileModel!.phoneNumber ??
                    'Add your phone number',
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Phone number is required";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Expanded(
            child: FilledButtonWidget(
              onPress: () async {
                if (formKey.currentState!.validate()) {
                  await profileCubit.editProfile(
                      fullName: fullNameController.text,
                      phoneNumber: phoneNubmerController.text);
                }
              },
              widget: const Text('Edit'),
            ),
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: const Center(child: LoadingWidget()));
  }
}
