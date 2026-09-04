import 'package:flutter/material.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/second_page.dart';

class SecondPageAdmin extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const SecondPageAdmin({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  State<SecondPageAdmin> createState() =>
      _SecondPageAdminState();
}

class _SecondPageAdminState extends State<SecondPageAdmin> {
  int currentSelection = 0;
  void switchSelection(int index) {
    setState(() {
      currentSelection = index;
    });
  }

  int filterIndex = 0;

  void setFilterIndex(int index) {
    setState(() {
      filterIndex = index;
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
              lastWidget: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Material(
                  type: MaterialType.transparency,
                  child: PopupMenuButton(
                    offset: Offset(-20, 30),
                    color: Colors.white,
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          onTap: () {
                            setFilterIndex(0);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b3
                                        .fontSize,
                                    fontWeight:
                                        filterIndex == 0
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                  'Filter By Subscription',
                                ),
                                Visibility(
                                  visible: filterIndex == 0,
                                  child: Icon(
                                    size: 17,
                                    color: Colors
                                        .grey
                                        .shade700,
                                    Icons.check,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setFilterIndex(1);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b3
                                        .fontSize,
                                    fontWeight:
                                        filterIndex == 1
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                  'Filter By Active/Inactive',
                                ),
                                Visibility(
                                  visible: filterIndex == 1,
                                  child: Icon(
                                    size: 17,
                                    color: Colors
                                        .grey
                                        .shade700,
                                    Icons.check,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            setFilterIndex(1);
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b3
                                        .fontSize,
                                    fontWeight:
                                        filterIndex == 1
                                        ? FontWeight.bold
                                        : null,
                                  ),
                                  'Filter By Assigned Agent',
                                ),
                                Visibility(
                                  visible: filterIndex == 1,
                                  child: Icon(
                                    size: 17,
                                    color: Colors
                                        .grey
                                        .shade700,
                                    Icons.check,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ];
                    },
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.more_vert_rounded),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: const Color.fromARGB(
                          41,
                          17,
                          82,
                          134,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
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
                            title: 'Head',
                            action: () {
                              switchSelection(1);
                            },
                          ),
                          TopStoreFilterButton(
                            mainIndex: currentSelection,
                            myIndex: 2,
                            title: 'Paid',
                            action: () {
                              switchSelection(2);
                            },
                          ),
                          TopStoreFilterButton(
                            mainIndex: currentSelection,
                            myIndex: 3,
                            title: 'Unpaid',
                            action: () {
                              switchSelection(3);
                            },
                          ),
                          TopStoreFilterButton(
                            mainIndex: currentSelection,
                            myIndex: 4,
                            title: 'New',
                            action: () {
                              switchSelection(4);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return returnShopProvider().getShops();
                },
                backgroundColor: Colors.white,
                color: theme.lightModeColor.prColor250,
                child: Builder(
                  builder: (context) {
                    if (currentSelection == 1
                        ? returnShopProvider(
                            context: context,
                          ).shopInfos.isEmpty
                        : currentSelection == 2
                        ? returnShopProvider(
                                context: context,
                              )
                              .getTotalSubscribedShops()
                              .isEmpty
                        : currentSelection == 3
                        ? returnShopProvider(
                            context: context,
                          ).getTotalFreeShops().isEmpty
                        : currentSelection == 4
                        ? returnShopProvider(
                                context: context,
                              )
                              .getThisMonthRegisteredStores()
                              .isEmpty
                        : returnShopProvider(
                            context: context,
                          ).shopInfos.isEmpty) {
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
                                  ).shopInfos
                                  .where((sh) => true)
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
                                  .getTotalSubscribedShops()
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
                                  .getTotalFreeShops()
                                  .map(
                                    (shop) => ShopTileMain(
                                      shop: shop,
                                    ),
                                  )
                                  .toList()
                            : currentSelection == 4
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
                            : returnShopProvider(
                                    context: context,
                                  ).shopInfos
                                  .where((sh) => true)
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
