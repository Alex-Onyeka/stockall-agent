import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_tab_widget.dart';

class SubscriptionDetailsSection extends StatelessWidget {
  const SubscriptionDetailsSection({
    super.key,
    required this.shop,
  });

  final ShopInfo shop;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.currentPlanName(),
                title: 'Current Plan',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.oldPlanName(),
                title: 'Old Plan',
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatDate(
                  shop.subscriptionLastPayment ??
                      DateTime.now(),
                ),
                title: 'Last Payment',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.getRemainingDays(),
                title: 'Next Payment',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
