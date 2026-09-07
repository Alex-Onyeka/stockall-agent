import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_tab_widget.dart';

class OwnersDetailsSection extends StatelessWidget {
  const OwnersDetailsSection({
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
                body: shop.userName ?? 'Not Set',
                title: 'Owner\'s Name',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                body: shop.userEmail ?? 'Not Set',
                isCopy: true,
                title: 'Owner\'s Email',
                action: () {
                  // print('Copying shit');
                  Clipboard.setData(
                    ClipboardData(
                      text: shop.userEmail ?? '',
                    ),
                  );

                  showSnackbar(
                    message:
                        'Owner\'s Email has been copied to clipboard.',
                    title: 'Copied to Clipboard!',
                    context: context,
                    actionResult: ActionResult().success,
                  );
                },
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
                isCopy: true,
                body: shop.userPhone ?? 'Not Set',
                title: 'Owner\'s Phone',
                action: () {
                  // print('Copying shit');
                  Clipboard.setData(
                    ClipboardData(
                      text: shop.userPhone ?? '',
                    ),
                  );

                  showSnackbar(
                    message:
                        'Owner\'s Phone Number has been copied to clipboard.',
                    title: 'Copied to Clipboard!',
                    context: context,
                    actionResult: ActionResult().success,
                  );
                },
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
      ],
    );
  }
}
