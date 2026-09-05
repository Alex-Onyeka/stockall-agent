import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/second_page.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_tab_widget.dart';

class AgentDetailsSectionPage extends StatelessWidget {
  const AgentDetailsSectionPage({
    super.key,
    required this.agent,
  });

  final UserClass agent;

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
                body: '${agent.name} ${agent.lastName}',
                title: 'Name',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                isCopy: true,
                action: () {
                  // print('Copying shit');
                  Clipboard.setData(
                    ClipboardData(text: agent.phone ?? ''),
                  );

                  showSnackbar(
                    message:
                        'Agent Phone Number has been copied to clipboard.',
                    title: 'Copied to Clipboard!',
                    context: context,
                    actionResult: ActionResult().success,
                  );
                },
                body: "${agent.phone}",
                title: 'Phone',
              ),
            ),
          ],
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                body: agent.email,
                title: 'Email',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                action: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SecondPage(
                          agentUuid: agent.userId ?? 'hhh',
                        );
                      },
                    ),
                  );
                },
                body: returnShopProvider().shopInfos
                    .where(
                      (item) =>
                          item.agentUuid == agent.userId,
                    )
                    .length
                    .toString(),
                title: 'Total Shops',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
