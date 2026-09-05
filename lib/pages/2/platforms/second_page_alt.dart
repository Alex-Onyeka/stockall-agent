import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/second_page.dart';

class SecondPageAlt extends StatefulWidget {
  final String? agentUuid;
  const SecondPageAlt({super.key, this.agentUuid});

  @override
  State<SecondPageAlt> createState() =>
      _SecondPageAltState();
}

class _SecondPageAltState extends State<SecondPageAlt> {
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
    List<ShopInfo> shops = [];
    shops = returnShopProvider(context: context).shopInfos
        .where((item) {
          if (filterIndex == 0) {
            if (currentSelection == 0) {
              return true;
            } else if (currentSelection == 1) {
              return item.isSubscribed();
            } else if (currentSelection == 2) {
              return item.isFree();
            } else if (currentSelection == 3) {
              return item.getIsTrial();
            } else {
              return item.getIsExpired();
            }
          } else if (filterIndex == 2) {
            return true;
          } else if (filterIndex == 3) {
            return true;
          } else if (filterIndex == 4) {
            return true;
          } else {
            return true;
          }
        })
        .toList()
        .where((item) {
          if (widget.agentUuid != null) {
            return item.agentUuid == widget.agentUuid;
          } else {
            return true;
          }
        })
        .toList();

    var theme = returnTheme(context: context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {},
      child: Scaffold(
        body: Column(
          children: [
            MainTopBar(
              agentUuid: widget.agentUuid,
              profileNavAction: null,
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
                    if (shops.isEmpty) {
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
                        children: shops
                            .map(
                              (shop) =>
                                  ShopTileMain(shop: shop),
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
