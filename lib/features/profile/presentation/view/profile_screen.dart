import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_app_2/core/widget/not_authenticated_widget.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_cubit.dart';
import 'package:market_app_2/features/authentication/presentation/model_views/auto_authenticate/auto_authentication_state.dart';
import 'package:market_app_2/features/profile/presentation/model_views/profile_cubit.dart';
import '../../../../core/style/app_colors.dart';
import '../../../../core/widget/divider_continer.dart';
import '../../../order/presentation/views/orders_history_screen.dart';
import '../model_views/profile_states.dart';
import 'widgets/edit_button_widget.dart';
import 'widgets/items_collection.dart';
import 'widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AutoAuthenticationCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: auth.state.authenticationState != AuthenticationStates.authenticated
          ? const NotAuthenticatedWidget()
          : ListView(
              padding: const EdgeInsets.all(10),
              children: [
                const SizedBox(height: 10),
                // the user information
                BlocBuilder<ProfileCubit, ProfileStates>(
                  builder: (context, state) {
                    if (state is ProfileSuccessState) {
                      return Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          ItemsCollection(
                            collectionTitle: 'My Info',
                            collectionItems: [
                              //Todo: user info
                              ProfileItem(
                                title: state.userProfileModel?.fullName ?? '',
                                icon: Icons.person_2_outlined,
                                onTap: () {},
                              ),
                              //Todo: user info
                              ProfileItem(
                                title: state.userProfileModel?.email ?? '',
                                icon: Icons.email_outlined,
                                onTap: () {},
                              ),
                              if (state.userProfileModel?.phoneNumber != null)
                                //Todo: user info
                                ProfileItem(
                                  title:
                                      state.userProfileModel?.phoneNumber ?? '',
                                  icon: Icons.phone_outlined,
                                  onTap: () {},
                                ),
                            ],
                          ),
                          const EditButton(),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 15),
                // the user settings
                ItemsCollection(
                  collectionTitle: 'Settings',
                  collectionItems: [
                    //Todo Customer Addresses
                    ProfileItem(
                      isButton: true,
                      title: 'Addresses',
                      icon: Icons.place_outlined,
                      onTap: () {},
                    ),
                    const DividerContiner(),
                    //Todo payment methods
                    ProfileItem(
                      isButton: true,
                      title: 'Payment Methods',
                      icon: Icons.wallet_outlined,
                      onTap: () {},
                    ),
                    const DividerContiner(),
                    //Todo orders history
                    ProfileItem(
                      isButton: true,
                      title: 'Orders History',
                      icon: Icons.shopping_basket_outlined,
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(OrdersHistoryScreen.routeName);
                      },
                    ),
                    const DividerContiner(),
                    //Todo languages
                    ProfileItem(
                      isButton: true,
                      title: 'Languages',
                      icon: Icons.language_outlined,
                      onTap: () {},
                    ),
                    const DividerContiner(),
                    //Todo help
                    ProfileItem(
                      isButton: true,
                      title: 'Help',
                      icon: Icons.help_outline_rounded,
                      onTap: () {},
                    ),
                    const DividerContiner(),
                    //Todo Signin as a driver
                    Container(
                      color: AppColors.primaryColor.withOpacity(.3),
                      child: ProfileItem(
                        isButton: true,
                        title: 'Sign In As A Driver',
                        icon: Icons.motorcycle_outlined,
                        onTap: () {},
                      ),
                    ),
                    const DividerContiner(),
                    //Todo Sign out
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red.withOpacity(.05),
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            bottomStart: Radius.circular(10),
                          )),
                      child: ProfileItem(
                        isButton: true,
                        title: 'Sign Out',
                        icon: Icons.logout_outlined,
                        onTap: () async {
                          await context
                              .read<AutoAuthenticationCubit>()
                              .signout();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
