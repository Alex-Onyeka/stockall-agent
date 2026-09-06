import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/second_page.dart';
import 'package:stockallagent/pages/agent_page/agent_page.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_tab_widget.dart';

class AgentDetailsSection extends StatelessWidget {
  const AgentDetailsSection({
    super.key,
    required this.shop,
  });

  final ShopInfo shop;

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme();
    return Column(
      spacing: 10,
      children: [
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: ShopDetailsTabWidget(
                action:
                    currentUser().userId != shop.agentUuid
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AgentPage(
                                agentUuid:
                                    shop.agentUuid ?? '',
                              );
                            },
                          ),
                        );
                      }
                    : null,
                body:
                    '${shop.agentFirstName} ${shop.agentLastName}',
                title: 'Name',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                isCopy: true,
                action: () {
                  print('Copying shit');
                  Clipboard.setData(
                    ClipboardData(
                      text: shop.agentPhone ?? '',
                    ),
                  );

                  showSnackbar(
                    message:
                        'Agent Phone Numberhas been copied to clipboard.',
                    title: 'Copied to Clipboard!',
                    context: context,
                    actionResult: ActionResult().success,
                  );
                },
                body: "${shop.agentPhone}",
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
                body: '${shop.agentEmail}',
                title: 'Email',
              ),
            ),
            Expanded(
              child: ShopDetailsTabWidget(
                action: () {
                  if ((shop.agentUuid !=
                          currentUser().userId
                      ? topAdmin()
                      : true)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SecondPage(
                            agentUuid: shop.agentUuid,
                          );
                        },
                      ),
                    );
                  }
                },
                body: returnShopProvider().shopInfos
                    .where(
                      (item) =>
                          item.agentUuid == shop.agentUuid,
                    )
                    .length
                    .toString(),
                title: 'Total Shops',
              ),
            ),
          ],
        ),
        Visibility(
          visible: topAdmin(),
          child: Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.redAccent),
                color: const Color.fromARGB(
                  20,
                  244,
                  67,
                  54,
                ),
              ),
              child: InkWell(
                onTap: () {
                  if (!returnShopProvider().isLoading &&
                      topAdmin()) {
                    showDialog(
                      context: context,
                      builder: (firstContext) {
                        return DialogTemplate(
                          title: 'Remove Agent',
                          action: () async {
                            Navigator.of(
                              firstContext,
                            ).pop();
                            await returnShopProvider()
                                .setAgent(
                                  agentUuid: shop
                                      .agentAndShopUuid!,
                                  isDelete: true,
                                  shopId: shop.shopId
                                      .toInt(),
                                );
                          },
                          message:
                              'You are about to Remove this Agent From this Business. All Comments Created Will be deleted. Are you sure you want to proceed?',
                        );
                      },
                    );
                  }
                },
                mouseCursor: SystemMouseCursors.click,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 300,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),

                  child: Builder(
                    builder: (context) {
                      if (returnShopProvider().isLoading) {
                        return Center(
                          child: SizedBox(
                            height: 23,
                            width: 23,
                            child:
                                CircularProgressIndicator(
                                  color: Colors.amber,
                                  strokeWidth: 2,
                                ),
                          ),
                        );
                      } else {
                        return Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          spacing: 4,
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b3
                                    .fontSize,
                              ),
                              'Remove Agent',
                            ),
                            Icon(
                              size: 20,
                              color: Colors.red,
                              Icons.clear,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
