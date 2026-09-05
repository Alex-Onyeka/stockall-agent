import 'package:flutter/material.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class DashboardAgent extends StatefulWidget {
  final Function()? navigate;
  final Function()? profileNavAction;
  const DashboardAgent({
    super.key,
    this.navigate,
    this.profileNavAction,
  });

  @override
  State<DashboardAgent> createState() =>
      _DashboardAgentState();
}

class _DashboardAgentState extends State<DashboardAgent> {
  @override
  Widget build(BuildContext context) {
    var shopProv = returnShopProvider(context: context);
    var theme = returnTheme(context: context);
    return Scaffold(
      backgroundColor: theme.lightModeColor.prColor300,
      body: Column(
        children: [
          MainTopBar(
            profileNavAction: widget.profileNavAction,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return returnShopProvider().getShops();
                },
                backgroundColor: Colors.white,
                color: theme.lightModeColor.prColor250,
                child: ListView(
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(10),
                              color: const Color.fromARGB(
                                255,
                                1,
                                29,
                                53,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(
                                        5,
                                        0,
                                        0,
                                        0,
                                      ),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Total Stores',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getAllShops(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Headquaters',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .shopInfos
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                              ),
                                              'Branches',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalBranchShops(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height:
                                      isMobileSmall(context)
                                      ? 25
                                      : 30,
                                ),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Total Subsc.',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalSubscribedShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Subsc. Today',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTodaysSubscribedShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                              ),
                                              'New Stores',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTodaysRegisteredStores()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height:
                                      isMobileSmall(context)
                                      ? 25
                                      : 30,
                                ),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Total Trial',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalTrialShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Total Free',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalFreeShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Total Expired',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalExpiredShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height:
                                      isMobileSmall(context)
                                      ? 25
                                      : 30,
                                ),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Active',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalActiveShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Semi Active',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalSemiActiveShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        // width: 110,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                          spacing: 5,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b4
                                                    .fontSize,
                                                color: Colors
                                                    .white,
                                              ),
                                              'Inactive',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b2
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              formatNumber(
                                                shopProv
                                                    .getTotalInActiveShops()
                                                    .length
                                                    .toDouble(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentGeometry.xy(
                              -1.4,
                              0,
                            ),
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(
                                  15,
                                  255,
                                  255,
                                  255,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        spacing: 10,
                        children: [
                          Row(
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
                                  color: Colors.white,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                                'New Stores',
                              ),
                              InkWell(
                                mouseCursor:
                                    SystemMouseCursors
                                        .click,
                                onTap: widget.navigate,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.all(
                                        8.0,
                                      ),
                                  child: Row(
                                    spacing: 5,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b3
                                              .fontSize,
                                          fontWeight:
                                              FontWeight
                                                  .normal,
                                          color: theme
                                              .lightModeColor
                                              .secColor200,
                                        ),
                                        'See All',
                                      ),
                                      Icon(
                                        size: 12,
                                        color: theme
                                            .lightModeColor
                                            .secColor200,
                                        Icons
                                            .arrow_forward_ios_rounded,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.white38,
                          ),
                          Builder(
                            builder: (context) {
                              if (returnShopProvider(
                                    context: context,
                                  )
                                  .getThisMonthRegisteredStores()
                                  .isEmpty) {
                                return SizedBox(
                                  height: 250,
                                  child: EmptyWidget(
                                    isDashboard: true,
                                  ),
                                );
                              } else {
                                return Column(
                                  spacing: 0,
                                  children:
                                      returnShopProvider(
                                                context:
                                                    context,
                                              )
                                              .getThisMonthRegisteredStores()
                                              .length >
                                          10
                                      ? returnShopProvider(
                                              context:
                                                  context,
                                            )
                                            .getThisMonthRegisteredStores()
                                            .getRange(0, 10)
                                            .map(
                                              (shop) =>
                                                  ShopTileMain(
                                                    shop:
                                                        shop,
                                                  ),
                                            )
                                            .toList()
                                      : returnShopProvider(
                                              context:
                                                  context,
                                            )
                                            .getThisMonthRegisteredStores()
                                            .map(
                                              (shop) =>
                                                  ShopTileMain(
                                                    shop:
                                                        shop,
                                                  ),
                                            )
                                            .toList(),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
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
