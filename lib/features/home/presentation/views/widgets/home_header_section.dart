import 'package:flutter/material.dart';
import 'package:market_app_2/features/home/presentation/views/widgets/home_address_container.dart';

import 'basket_badge_widget.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Row(
        children: [
          Expanded(
            child: HomeAddressContainer(),
          ),
          SizedBox(width: 20),
          BasketBadgeWidget(),
        ],
      ),
    );
  }
}
