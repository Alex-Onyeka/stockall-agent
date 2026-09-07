import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_tab_widget.dart';

class OperationsDetailsSection extends StatelessWidget {
  const OperationsDetailsSection({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.totalReceipts),
                title: 'Total Sales',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.todaysReceipts),
                title: 'Today\'s Sales',
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.totalInvoice),
                title: 'Total Invoices',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.todaysInvoice),
                title: 'Today\'s Invoices',
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.totalProducts),
                title: 'Total Products',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.todaysProducts),
                title: 'Today\'s Products',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
