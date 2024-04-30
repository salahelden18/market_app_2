import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/core/widget/divider_continer.dart';
import 'package:market_app_2/features/profile/presentation/widgets/edit_button_widget.dart';
import 'package:market_app_2/features/profile/presentation/widgets/items_collection.dart';
import 'package:market_app_2/features/profile/presentation/widgets/profile_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const SizedBox(height: 10),
          // the user information
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              ItemsCollection(
                collectionTitle: 'My Info',
                collectionItems: [
                  //Todo: user info
                  ProfileItem(
                    title: 'sfsdfsd',
                    icon: Icons.person_2_outlined,
                    onTap: () {},
                  ),
                  //Todo: user info
                  ProfileItem(
                    title: 'sfsdfsd',
                    icon: Icons.email_outlined,
                    onTap: () {},
                  ),
                  //Todo: user info
                  ProfileItem(
                    title: 'sfsdfsd',
                    icon: Icons.phone_outlined,
                    onTap: () {},
                  ),
                ],
              ),
              const EditButton(),
            ],
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
                onTap: () {},
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
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
