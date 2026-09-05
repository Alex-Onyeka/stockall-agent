import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_tab_widget.dart';

class ShopDetailsSection extends StatelessWidget {
  const ShopDetailsSection({super.key, required this.shop});

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
                body: shop.userName ?? 'Not Set',
                title: 'Owner\'s Name',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.userEmail ?? 'Not Set',
                title: 'Owner\'s Email',
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
                body: shop.userPhone ?? 'Not Set',
                title: 'Owner\'s Phone',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.userRole ?? 'Not Set',
                title: 'Owner\'s Role',
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
                body: shop.country ?? 'Not Set',
                title: 'Country',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.state ?? 'Not Set',
                title: 'State',
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
                body: shop.city ?? 'Not Set',
                title: 'City',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.shopAddress ?? 'Not Set',
                title: 'Address',
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
                body: formatNumber(shop.shopBranches),
                title: 'Branches',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: formatNumber(shop.totalStaffs ?? 0),
                title: 'Staffs',
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
                body: formatDate(shop.shopCreatedAt),
                title: 'Created Date',
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: 0,
                child: ShopDetailsTabWidget(
                  body: formatNumber(shop.totalStaffs ?? 0),
                  title: 'Staffs',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
