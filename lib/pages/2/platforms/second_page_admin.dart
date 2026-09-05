import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
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
      toggleIsSearch(value: false);
    });
  }

  int filterIndex = 0;

  void setFilterIndex(int index) {
    setState(() {
      currentSelection = 0;
      filterIndex = index;
      toggleIsSearch(value: false);
    });
  }

  final searchController = TextEditingController();
  bool isSearch = false;
  void toggleIsSearch({bool? value}) {
    setState(() {
      if (value != null) {
        isSearch = value;
      } else {
        isSearch = !isSearch;
        filterIndex = 0;
        currentSelection = 0;
      }
      searchController.clear();
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
              return item.createdToday();
            } else if (currentSelection == 2) {
              return item.createdYesterday();
            } else if (currentSelection == 3) {
              return item.createdThisWeek();
            } else if (currentSelection == 4) {
              return item.createdLastWeek();
            } else if (currentSelection == 5) {
              return item.createdThisMonth();
            } else if (currentSelection == 6) {
              return item.createdLastMonth();
            } else if (currentSelection == 7) {
              return item.createdThisYear();
            } else if (currentSelection == 8) {
              return item.createdLastYear();
            } else {
              return true;
            }
          } else if (filterIndex == 1) {
            if (currentSelection == 0) {
              return true;
            } else if (currentSelection == 1) {
              return item.isSubscribed();
            } else if (currentSelection == 2) {
              return item.isTrial;
            } else if (currentSelection == 3) {
              return item.isFree();
            } else if (currentSelection == 4) {
              return item.isExpired;
            } else if (currentSelection == 5) {
              return item.isBasicPlan();
            } else if (currentSelection == 6) {
              return item.isStandardPlan();
            } else if (currentSelection == 7) {
              return item.isPremiumPlan();
            } else if (currentSelection == 8) {
              return item.isSilverPlan();
            } else {
              return item.isGoldPlan();
            }
          } else if (filterIndex == 2) {
            if (currentSelection == 0) {
              return true;
            } else if (currentSelection == 1) {
              return item.isActive;
            } else if (currentSelection == 2) {
              return item.isSemiActive;
            } else if (currentSelection == 3) {
              return item.isInactive;
            } else {
              return true;
            }
          } else if (filterIndex == 3) {
            if (currentSelection == 0) {
              return true;
            } else if (currentSelection == 1) {
              return item.agentUuid != null;
            } else if (currentSelection == 2) {
              return item.agentUuid == null;
            } else {
              return true;
            }
          } else {
            return true;
          }
        })
        .where(
          (item) =>
              item.shopName.toLowerCase().contains(
                searchController.text.toLowerCase(),
              ) ||
              item.userName?.toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ) ==
                  true ||
              item.agentFirstName?.toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ) ==
                  true ||
              item.country?.toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ) ==
                  true ||
              item.currentPlan
                      ?.toString()
                      .toLowerCase()
                      .contains(
                        searchController.text.toLowerCase(),
                      ) ==
                  true ||
              item.currentPlanName().toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ) ==
                  true,
        )
        .toList();
    if (currentSelection == 1) {
      shops.sort(
        (a, b) => b.getLastPayment().compareTo(
          a.getLastPayment(),
        ),
      );
    } else if (filterIndex == 4) {
      if (currentSelection == 0) {
        shops.sort(
          (a, b) => a.shopName.toLowerCase().compareTo(
            b.shopName.toLowerCase(),
          ),
        );
      } else if (currentSelection == 1) {
        shops.sort(
          (a, b) => a.userName!.toLowerCase().compareTo(
            b.userName!.toLowerCase(),
          ),
        );
      } else if (currentSelection == 2) {
        shops.sort(
          (a, b) =>
              b.shopCreatedAt.compareTo(a.shopCreatedAt),
        );
      } else if (currentSelection == 3) {
        shops.sort(
          (a, b) => b.getLastActivity().compareTo(
            a.getLastActivity(),
          ),
        );
      } else if (currentSelection == 4) {
        shops.sort(
          (a, b) => b.getExpiryDate().compareTo(
            a.getExpiryDate(),
          ),
        );
      }
    } else {
      shops.sort(
        (a, b) => a.shopName.toLowerCase().compareTo(
          b.shopName.toLowerCase(),
        ),
      );
    }
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
              lastWidget: Material(
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
                                'Filter By Created Date',
                              ),
                              Visibility(
                                visible: filterIndex == 0,
                                child: Icon(
                                  size: 17,
                                  color:
                                      Colors.grey.shade700,
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
                                'Filter By Subscription',
                              ),
                              Visibility(
                                visible: filterIndex == 1,
                                child: Icon(
                                  size: 17,
                                  color:
                                      Colors.grey.shade700,
                                  Icons.check,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          setFilterIndex(2);
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
                                      filterIndex == 2
                                      ? FontWeight.bold
                                      : null,
                                ),
                                'Filter By Active/Inactive',
                              ),
                              Visibility(
                                visible: filterIndex == 2,
                                child: Icon(
                                  size: 17,
                                  color:
                                      Colors.grey.shade700,
                                  Icons.check,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          setFilterIndex(3);
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
                                      filterIndex == 3
                                      ? FontWeight.bold
                                      : null,
                                ),
                                'Filter By Assigned Agent',
                              ),
                              Visibility(
                                visible: filterIndex == 3,
                                child: Icon(
                                  size: 17,
                                  color:
                                      Colors.grey.shade700,
                                  Icons.check,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          setFilterIndex(4);
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
                                      filterIndex == 4
                                      ? FontWeight.bold
                                      : null,
                                ),
                                'Sort List',
                              ),
                              Visibility(
                                visible: filterIndex == 4,
                                child: Icon(
                                  size: 17,
                                  color:
                                      Colors.grey.shade700,
                                  Icons.check,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          toggleIsSearch();
                        },
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.start,
                            spacing: 5,
                            children: [
                              Icon(
                                size: 17,
                                color: Colors.grey.shade700,
                                Icons.search,
                              ),
                              Text(
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b3
                                      .fontSize,
                                ),
                                'Search Shops',
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Builder(
                builder: (context) {
                  if (isSearch) {
                    return Row(
                      spacing: 5,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 400,
                          height: 40,
                          child: MyTextFieldMain(
                            autoFocus: true,
                            onChange: (value) {
                              setState(() {});
                            },
                            controller: searchController,
                            isEmail: false,
                            showTitle: false,
                            isNumber: false,
                            isOptional: true,
                            hintText: 'Enter Text',
                            isPassword: false,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            toggleIsSearch();
                          },
                          mouseCursor:
                              SystemMouseCursors.click,
                          child: Padding(
                            padding: EdgeInsetsGeometry.all(
                              10,
                            ),
                            child: Icon(
                              size: 22,
                              Icons.clear,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10),
                              color: const Color.fromARGB(
                                41,
                                17,
                                82,
                                134,
                              ),
                            ),
                            child: Builder(
                              builder: (context) {
                                if (filterIndex == 0) {
                                  return findByCreatedDateWidget(
                                    shops,
                                  );
                                } else if (filterIndex ==
                                    1) {
                                  return findBySubscriptionWidget(
                                    shops,
                                  );
                                } else if (filterIndex ==
                                    2) {
                                  return findByActivityWidget(
                                    shops,
                                  );
                                } else if (filterIndex ==
                                    3) {
                                  return findByAssignedAgentsWidget(
                                    shops,
                                  );
                                } else if (filterIndex ==
                                    4) {
                                  return sortWidget(shops);
                                } else {
                                  return findByCreatedDateWidget(
                                    shops,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
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
                              (shop) => ShopTileMain(
                                shop: shop,
                                sortInt: filterIndex == 4
                                    ? currentSelection
                                    : (filterIndex == 1 &&
                                          currentSelection ==
                                              1)
                                    ? 5
                                    : null,
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

  Row findByCreatedDateWidget(List<ShopInfo> shops) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 0,
          title:
              'All${currentSelection == 0 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(0);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 1,
          title:
              'Today${currentSelection == 1 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(1);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 2,
          title:
              'Yesterday${currentSelection == 2 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(2);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 3,
          title:
              'This Week${currentSelection == 3 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(3);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 4,
          title:
              'Last Week${currentSelection == 4 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(4);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 5,
          title:
              'This Month${currentSelection == 5 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(5);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 6,
          title:
              'Last Month${currentSelection == 6 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(6);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 7,
          title:
              'This Year${currentSelection == 7 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(7);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 8,
          title:
              'Last Year${currentSelection == 8 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(8);
          },
        ),
      ],
    );
  }

  Row findBySubscriptionWidget(List<ShopInfo> shops) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 0,
          title:
              'All${currentSelection == 0 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(0);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 1,
          title:
              'Latest${currentSelection == 1 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(1);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 2,
          title:
              'Trial${currentSelection == 2 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(2);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 3,
          title:
              'Free${currentSelection == 3 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(3);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 4,
          title:
              'Expired${currentSelection == 4 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(4);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 5,
          title:
              'Basic${currentSelection == 5 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(5);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 6,
          title:
              'Standard${currentSelection == 6 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(6);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 7,
          title:
              'Premium${currentSelection == 7 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(7);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 8,
          title:
              'Silver${currentSelection == 8 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(8);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 9,
          title:
              'Gold${currentSelection == 9 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(9);
          },
        ),
      ],
    );
  }

  Row findByActivityWidget(List<ShopInfo> shops) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 0,
          title:
              'All${currentSelection == 0 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(0);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 1,
          title:
              'Active${currentSelection == 1 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(1);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 2,
          title:
              'Semi Active${currentSelection == 2 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(2);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 3,
          title:
              'Inactive${currentSelection == 3 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(3);
          },
        ),
      ],
    );
  }

  Row findByAssignedAgentsWidget(List<ShopInfo> shops) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 0,
          title:
              'All${currentSelection == 0 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(0);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 1,
          title:
              'Is Managed${currentSelection == 1 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(1);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 2,
          title:
              'Un-Managed${currentSelection == 2 ? " (${shops.length})" : ''}',
          action: () {
            switchSelection(2);
          },
        ),
      ],
    );
  }

  Row sortWidget(List<ShopInfo> shops) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 0,
          title: 'Shop Name',
          action: () {
            switchSelection(0);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 1,
          title: 'Owner\'s Name',
          action: () {
            switchSelection(1);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 2,
          title: 'Created Date',
          action: () {
            switchSelection(2);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 3,
          title: 'Last Activity',
          action: () {
            switchSelection(3);
          },
        ),
        TopStoreFilterButton(
          mainIndex: currentSelection,
          myIndex: 4,
          title: 'Expiry Date',
          action: () {
            switchSelection(4);
          },
        ),
      ],
    );
  }
}
