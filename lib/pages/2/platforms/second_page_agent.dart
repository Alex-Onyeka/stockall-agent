import 'package:flutter/material.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/second_page.dart';

class SecondPageAgent extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const SecondPageAgent({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  State<SecondPageAgent> createState() =>
      _SecondPageAgentState();
}

class _SecondPageAgentState extends State<SecondPageAgent> {
  int currentSelection = 0;
  void switchSelection(int index) {
    setState(() {
      currentSelection = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        widget.popPage!();
      },
      child: Scaffold(
        body: Column(
          children: [
            MainTopBar(
              profileNavAction: widget.profileNavAction,
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(
                    41,
                    17,
                    82,
                    134,
                  ),
                ),
                child: Row(
                  children: [
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 0,
                      title: 'All',
                      action: () {
                        switchSelection(0);
                      },
                    ),
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 1,
                      title: 'Paid',
                      action: () {
                        switchSelection(1);
                      },
                    ),
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 2,
                      title: 'Unpaid',
                      action: () {
                        switchSelection(2);
                      },
                    ),
                    TopStoreFilterButton(
                      mainIndex: currentSelection,
                      myIndex: 3,
                      title: 'New',
                      action: () {
                        switchSelection(3);
                      },
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return returnShopProvider(
                    context: context,
                    listen: false,
                  ).getShops(context);
                },
                backgroundColor: Colors.white,
                color: theme.lightModeColor.prColor250,
                child: Builder(
                  builder: (context) {
                    if (currentSelection == 1
                        ? returnShopProvider(
                                context: context,
                              )
                              .getTotalSubscribedShops(
                                context,
                              )
                              .isEmpty
                        : currentSelection == 2
                        ? returnShopProvider(
                                context: context,
                              )
                              .getTotalUnsubscribedShops(
                                context,
                              )
                              .isEmpty
                        : currentSelection == 3
                        ? returnShopProvider(
                                context: context,
                              )
                              .getThisMonthRegisteredStores()
                              .isEmpty
                        : returnShopProvider(
                            context: context,
                          ).getHeadQuaters().isEmpty) {
                      return ListView(
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(
                                  context,
                                ).size.height -
                                200,
                            child: EmptyWidget(
                              isDashboard: false,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        children: currentSelection == 1
                            ? returnShopProvider(
                                    context: context,
                                  )
                                  .getTotalSubscribedShops(
                                    context,
                                  )
                                  .map(
                                    (shop) => ShopTileMain(
                                      shop: shop,
                                    ),
                                  )
                                  .toList()
                            : currentSelection == 2
                            ? returnShopProvider(
                                    context: context,
                                  )
                                  .getTotalUnsubscribedShops(
                                    context,
                                  )
                                  .map(
                                    (shop) => ShopTileMain(
                                      shop: shop,
                                    ),
                                  )
                                  .toList()
                            : currentSelection == 3
                            ? returnShopProvider(
                                    context: context,
                                  )
                                  .getThisMonthRegisteredStores()
                                  .map(
                                    (shop) => ShopTileMain(
                                      shop: shop,
                                    ),
                                  )
                                  .toList()
                                  .toList()
                            : returnShopProvider(
                                    context: context,
                                  )
                                  .getHeadQuaters()
                                  .where(
                                    (sh) =>
                                        returnSubscriptionProvider(
                                              context:
                                                  context,
                                            ).subscriptions
                                            .map(
                                              (sub) => sub
                                                  .userId,
                                            )
                                            .toList()
                                            .contains(
                                              sh.userId,
                                            ),
                                  )
                                  .map(
                                    (shop) => ShopTileMain(
                                      shop: shop,
                                    ),
                                  )
                                  .toList(),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
