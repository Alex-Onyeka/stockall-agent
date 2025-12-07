import 'package:flutter/material.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/main.dart';

class Stores extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const Stores({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  State<Stores> createState() => _StoresState();
}

class _StoresState extends State<Stores> {
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
                      title: 'All Stores',
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
                        : returnShopProvider(
                            context: context,
                          ).shops.isEmpty) {
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
                            : returnShopProvider(
                                    context: context,
                                  ).shops
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

class TopStoreFilterButton extends StatelessWidget {
  final int myIndex;
  final int mainIndex;
  final String title;
  final Function()? action;

  const TopStoreFilterButton({
    super.key,
    required this.myIndex,
    required this.mainIndex,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: mainIndex == myIndex
                ? theme.lightModeColor.prColor300
                : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 20,
              ),

              child: Center(
                child: Text(
                  style: TextStyle(
                    fontSize: theme.mobileTexts.b4.fontSize,
                    fontWeight: mainIndex == myIndex
                        ? FontWeight.bold
                        : null,
                    color: mainIndex == myIndex
                        ? Colors.white
                        : theme.lightModeColor.prColor300,
                  ),
                  title,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
