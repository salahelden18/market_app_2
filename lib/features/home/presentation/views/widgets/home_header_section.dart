import 'package:flutter/material.dart';
import 'package:market_app_2/core/style/app_colors.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/home_address_container.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          const Expanded(
            child: HomeAddressContainer(),
          ),
          const SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
