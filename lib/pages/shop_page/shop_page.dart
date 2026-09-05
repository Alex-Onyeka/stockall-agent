import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/shop_page/components/agent_details_section.dart';
import 'package:stockallagent/pages/shop_page/components/comments_list_widget.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_main_section.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_section.dart';
import 'package:stockallagent/pages/shop_page/components/subscription_details_section.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class ShopPage extends StatelessWidget {
  final int shopId;
  const ShopPage({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    ShopInfo shop = returnShopProvider(
      context: context,
    ).shopInfos.firstWhere((item) => item.shopId == shopId);
    var theme = returnTheme();
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: theme.lightModeColor.prColor300,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      mouseCursor: SystemMouseCursors.click,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        color: Colors.grey.shade200,
                        size: 20,
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b2.fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      'Shop Details',
                    ),
                    Opacity(
                      opacity: 0,
                      child: IconButton(
                        mouseCursor:
                            SystemMouseCursors.click,
                        onPressed: () {},
                        icon: Icon(
                          color: Colors.white,
                          size: 20,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: const Color.fromARGB(
                    80,
                    158,
                    158,
                    158,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10,
                    10,
                    10,
                    10,
                  ),
                  child: Column(
                    spacing: 5,
                    children: [
                      Icon(
                        size: 25,
                        color: Colors.amber,
                        Icons.home_work_outlined,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.h4.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        shop.shopName.toUpperCase(),
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b5
                                  .fontSize,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400,
                            ),
                            "STATUS:",
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b5
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                            shop.activeText(),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: shop.activeColor(),
                            ),
                            padding: EdgeInsets.all(4),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        spacing: 5,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b5
                                  .fontSize,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.shade400,
                            ),
                            "Last Seen:".toUpperCase(),
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b5
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                            shop.getLastSeen(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                15.0,
                15,
                15,
                50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    Builder(
                      builder: (context) {
                        if (shop.agentEmail != null) {
                          return ShopDetailsMainSection(
                            title: 'Agent Details',
                            shop: shop,
                            widgett: AgentDetailsSection(
                              shop: shop,
                            ),
                          );
                        } else {
                          return EmptyAgentWidget(
                            shop: shop,
                            theme: theme,
                          );
                        }
                      },
                    ),
                    ShopDetailsMainSection(
                      title: 'Shop Details',
                      shop: shop,
                      widgett: ShopDetailsSection(
                        shop: shop,
                      ),
                    ),
                    ShopDetailsMainSection(
                      title: 'Subscription Details',
                      shop: shop,
                      widgett: SubscriptionDetailsSection(
                        shop: shop,
                      ),
                    ),
                    Visibility(
                      visible: shop.agentEmail != null,
                      child: ShopDetailsMainSection(
                        title: 'Comments',
                        shop: shop,
                        widgett: CommentsListWidget(
                          shop: shop,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyAgentWidget extends StatelessWidget {
  const EmptyAgentWidget({
    super.key,
    required this.shop,
    required this.theme,
  });

  final ShopInfo shop;
  final ThemeProvider theme;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: topAdmin(),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(28, 0, 0, 0),
                blurRadius: 10,
              ),
            ],
          ),
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              if (!returnShopProvider().isLoading &&
                  topAdmin()) {
                addAgentAction(
                  context: context,
                  shopId: shop.shopId.toInt(),
                );
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),

              child: Center(
                child: Builder(
                  builder: (context) {
                    if (returnShopProvider(
                      context: context,
                    ).isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          Icon(
                            size: 20,
                            color: theme
                                .lightModeColor
                                .tertColor200,
                            Icons.person_add_alt_1_outlined,
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b3
                                  .fontSize,
                            ),
                            'Add Agent',
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
    );
  }
}

void addAgentAction({
  required BuildContext context,
  required int shopId,
}) {
  var theme = returnTheme();
  showDialog(
    context: context,
    builder: (firstContext) {
      return DialogTemplate(
        title: 'Select Agent',
        subTitle:
            'Select An Agent from the List to Manage this Business',
        mainWidget: Column(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: returnUserProvider().agents
              .where((item) => item.roleId == 1)
              .map(
                (item) => Material(
                  type: MaterialType.transparency,
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                    ),
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (firstContext) {
                            return DialogTemplate(
                              title: 'Assign Agent',
                              action: () async {
                                Navigator.of(
                                  firstContext,
                                ).pop();
                                Navigator.of(context).pop();
                                await returnShopProvider()
                                    .setAgent(
                                      agentUuid:
                                          item.userId!,
                                      isDelete: false,
                                      shopId: shopId,
                                    );
                              },
                              message:
                                  'You are about to Assign this Agent to manage this Business. All Comments Created Will be deleted. Are you sure you want to proceed?',
                            );
                          },
                        );
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 15,
                        ),

                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          spacing: 5,
                          children: [
                            Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              spacing: 5,
                              children: [
                                Icon(
                                  size: 18,
                                  color: theme
                                      .lightModeColor
                                      .tertColor200,
                                  Icons.person_add_alt,
                                ),
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b3
                                        .fontSize,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                  "${item.name} ${item.lastName ?? ''}",
                                ),
                              ],
                            ),
                            Icon(
                              size: 18,
                              color: Colors.grey,
                              Icons
                                  .arrow_forward_ios_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    },
  );
}
