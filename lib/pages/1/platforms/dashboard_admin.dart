import 'package:flutter/material.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class DashboardAdmin extends StatefulWidget {
  final Function()? navigate;
  final Function()? profileNavAction;
  const DashboardAdmin({
    super.key,
    this.navigate,
    this.profileNavAction,
  });

  @override
  State<DashboardAdmin> createState() =>
      _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardAdmin> {
  bool viewMore = false;
  void toggleViewMore() {
    setState(() {
      viewMore = !viewMore;
    });
  }

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
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          toggleViewMore();
                        },
                        mouseCursor:
                            SystemMouseCursors.click,
                        child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 20,
                                    ),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        10,
                                      ),
                                  color:
                                      const Color.fromARGB(
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
                                      MainAxisAlignment
                                          .center,
                                  children: [
                                    DashboardRowWidget(
                                      showTopDivider: false,
                                      title1:
                                          'Total Stores',
                                      value1: formatNumber(
                                        shopProv
                                            .getAllShops(),
                                      ),
                                      title2: 'Headquaters',
                                      value2: formatNumber(
                                        shopProv
                                            .shopInfos
                                            .length
                                            .toDouble(),
                                      ),
                                      title3: 'Branches',
                                      value3: formatNumber(
                                        shopProv
                                            .getTotalBranchShops(),
                                      ),
                                    ),

                                    DashboardRowWidget(
                                      showTopDivider: true,
                                      title1: 'Active',
                                      value1: formatNumber(
                                        shopProv
                                            .getTotalActiveShops()
                                            .length
                                            .toDouble(),
                                      ),
                                      title2: 'Semi Active',
                                      value2: formatNumber(
                                        shopProv
                                            .getTotalSemiActiveShops()
                                            .length
                                            .toDouble(),
                                      ),
                                      title3: 'Inactive',
                                      value3: formatNumber(
                                        shopProv
                                            .getTotalInActiveShops()
                                            .length
                                            .toDouble(),
                                      ),
                                    ),

                                    DashboardRowWidget(
                                      showTopDivider: true,
                                      title1:
                                          'Total Subsc.',
                                      value1: formatNumber(
                                        shopProv
                                            .getTotalSubscribedShops()
                                            .length
                                            .toDouble(),
                                      ),
                                      title2:
                                          'Subsc. Today',
                                      value2: formatNumber(
                                        shopProv
                                            .getTodaysSubscribedShops()
                                            .length
                                            .toDouble(),
                                      ),
                                      title3: 'New Stores',
                                      value3: formatNumber(
                                        shopProv
                                            .getTodaysRegisteredStores()
                                            .length
                                            .toDouble(),
                                      ),
                                    ),

                                    DashboardRowWidget(
                                      showTopDivider: true,
                                      title1: 'Total Trial',
                                      value1: formatNumber(
                                        shopProv
                                            .getTotalTrialShops()
                                            .length
                                            .toDouble(),
                                      ),
                                      title2: 'Total Free',
                                      value2: formatNumber(
                                        shopProv
                                            .getTotalFreeShops()
                                            .length
                                            .toDouble(),
                                      ),
                                      title3:
                                          'Total Expired',
                                      value3: formatNumber(
                                        shopProv
                                            .getTotalExpiredShops()
                                            .length
                                            .toDouble(),
                                      ),
                                    ),
                                    Visibility(
                                      visible: viewMore,
                                      child: Column(
                                        children: [
                                          DashboardRowWidget(
                                            showTopDivider:
                                                true,
                                            title1:
                                                'Total Basic',
                                            value1: formatNumber(
                                              shopProv
                                                  .getTotalSubscribedBasic()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title2:
                                                'Total Standard',
                                            value2: formatNumber(
                                              shopProv
                                                  .getTotalSubscribedStandard()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title3:
                                                'Total Premium',
                                            value3: formatNumber(
                                              shopProv
                                                  .getTotalSubscribedPremium()
                                                  .length
                                                  .toDouble(),
                                            ),
                                          ),
                                          DashboardRowWidget(
                                            showTopDivider:
                                                true,
                                            title1:
                                                'Total Silver',
                                            value1: formatNumber(
                                              shopProv
                                                  .getTotalSubscribedSilver()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title2:
                                                'Total Gold',
                                            value2: formatNumber(
                                              shopProv
                                                  .getTotalSubscribedGold()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title3: '',
                                            value3: formatNumber(
                                              shopProv
                                                  .getTotalSubscribedPremium()
                                                  .length
                                                  .toDouble(),
                                            ),
                                          ),
                                          DashboardRowWidget(
                                            showTopDivider:
                                                true,
                                            title1:
                                                'Today\'s Free',
                                            value1: formatNumber(
                                              shopProv
                                                  .getTodaysSubscribedShopsFree()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title2:
                                                'Today\'s Basic',
                                            value2: formatNumber(
                                              shopProv
                                                  .getTodaysSubscribedShopsBasic()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title3:
                                                'Today\'s Standard',
                                            value3: formatNumber(
                                              shopProv
                                                  .getTodaysSubscribedShopsStandard()
                                                  .length
                                                  .toDouble(),
                                            ),
                                          ),
                                          DashboardRowWidget(
                                            showTopDivider:
                                                true,
                                            title1:
                                                'Today\'s Premium',
                                            value1: formatNumber(
                                              shopProv
                                                  .getTodaysSubscribedShopsPremium()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title2:
                                                'Today\'s Silver',
                                            value2: formatNumber(
                                              shopProv
                                                  .getTodaysSubscribedShopsSilver()
                                                  .length
                                                  .toDouble(),
                                            ),
                                            title3:
                                                'Today\'s Gold',
                                            value3: formatNumber(
                                              shopProv
                                                  .getTodaysSubscribedShopsGold()
                                                  .length
                                                  .toDouble(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                      children: [
                                        Material(
                                          type: MaterialType
                                              .transparency,
                                          child: InkWell(
                                            mouseCursor:
                                                SystemMouseCursors
                                                    .click,
                                            onTap: () {
                                              toggleViewMore();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal:
                                                        10,
                                                    vertical:
                                                        5.0,
                                                  ),
                                              child: Row(
                                                mainAxisSize:
                                                    MainAxisSize
                                                        .min,
                                                spacing: 4,

                                                children: [
                                                  Text(
                                                    style: TextStyle(
                                                      fontSize: theme
                                                          .mobileTexts
                                                          .b5
                                                          .fontSize,
                                                      color:
                                                          Colors.amber,
                                                    ),
                                                    viewMore
                                                        ? 'View Less'
                                                        : 'View More',
                                                  ),
                                                  Icon(
                                                    size:
                                                        20,
                                                    color: Colors
                                                        .amber,
                                                    viewMore
                                                        ? Icons.keyboard_arrow_up_rounded
                                                        : Icons.keyboard_arrow_down_rounded,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment:
                                    AlignmentGeometry.xy(
                                      -1.4,
                                      0,
                                    ),
                                child: Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        const Color.fromARGB(
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
                                returnShopProvider(
                                          context: context,
                                        )
                                        .getAssignedStores()
                                        .isNotEmpty
                                    ? 'Assigned Stores'
                                    : 'New Stores',
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
                                        'See All Stores',
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
                                  .getAssignedStores()
                                  .isNotEmpty) {
                                return Column(
                                  spacing: 0,
                                  children:
                                      returnShopProvider(
                                                context:
                                                    context,
                                              )
                                              .getAssignedStores()
                                              .length >
                                          10
                                      ? returnShopProvider(
                                              context:
                                                  context,
                                            )
                                            .getAssignedStores()
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
                                            .getAssignedStores()
                                            .map(
                                              (
                                                shop,
                                              ) => ShopTileMain(
                                                shop: shop,
                                                sortInt: 1,
                                              ),
                                            )
                                            .toList(),
                                );
                              } else {
                                return Builder(
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
                                                ).getThisMonthRegisteredStores().length >
                                                10
                                            ? returnShopProvider(
                                                    context:
                                                        context,
                                                  )
                                                  .getThisMonthRegisteredStores()
                                                  .getRange(
                                                    0,
                                                    10,
                                                  )
                                                  .map(
                                                    (
                                                      shop,
                                                    ) => ShopTileMain(
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
                                                    (
                                                      shop,
                                                    ) => ShopTileMain(
                                                      shop:
                                                          shop,
                                                    ),
                                                  )
                                                  .toList(),
                                      );
                                    }
                                  },
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

//
//
//
//
//
//
//
//

class DashboardRowWidget extends StatelessWidget {
  final bool showTopDivider;
  final String title1;
  final String value1;
  final String title2;
  final String value2;
  final String title3;
  final String value3;
  const DashboardRowWidget({
    super.key,
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
    required this.title3,
    required this.value3,
    required this.showTopDivider,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme();
    return Column(
      children: [
        Visibility(
          visible: showTopDivider,
          child: Divider(
            height: isMobileSmall(context) ? 25 : 30,
          ),
        ),
        Row(
          // spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Opacity(
                      opacity: title1.isNotEmpty ? 1 : 0,
                      child: SizedBox(
                        // width: 110,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b4
                                    .fontSize,
                                color: Colors.white,
                              ),
                              title1,
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b2
                                    .fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              value1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 50,
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Opacity(
                opacity: title2.isNotEmpty ? 1 : 0,
                child: SizedBox(
                  // width: 110,
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.b4.fontSize,
                          color: Colors.white,
                        ),
                        title2,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.b2.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        value2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 50,
                    width: 1,
                    color: Colors.grey.shade400,
                  ),
                  Expanded(
                    child: Opacity(
                      opacity: title3.isNotEmpty ? 1 : 0,
                      child: SizedBox(
                        // width: 110,
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b4
                                    .fontSize,
                                color: Colors.white,
                              ),
                              title3,
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b2
                                    .fontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              value3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/*

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
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  spacing: 10,
                                  children: [
                                    Column(
                                      spacing: 2,
                                      crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
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
                                          'Net Revenue',
                                        ),
                                        Text(
                                          style: TextStyle(
                                            fontSize: theme
                                                .mobileTexts
                                                .h1
                                                .fontSize,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                            color: Colors
                                                .white,
                                          ),
                                          returnResourceProvider(
                                                context:
                                                    context,
                                              ).hideMoneyDashBoard
                                              ? '********'
                                              : formatMoney(
                                                  2000,
                                                ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      mouseCursor:
                                          SystemMouseCursors
                                              .click,
                                      onTap: () {
                                        returnResourceProvider()
                                            .toggleHideMoney();
                                      },
                                      child: Icon(
                                        color: Colors.white,
                                        returnResourceProvider(
                                              context:
                                                  context,
                                            ).hideMoneyDashBoard
                                            ? Icons
                                                  .desktop_access_disabled_rounded
                                            : Icons
                                                  .desktop_mac_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height:isMobileSmall(context) ? 25 : 30),
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
                                              'Total Revenue',
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
                                              returnResourceProvider(
                                                    context:
                                                        context,
                                                  ).hideMoneyDashBoard
                                                  ? '***'
                                                  : formatMoney(2000),
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
                                              'Referrals Cut',
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
                                              returnResourceProvider(
                                                    context:
                                                        context,
                                                  ).hideMoneyDashBoard
                                                  ? '***'
                                                  : formatMoney(1000),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height:isMobileSmall(context) ? 25 : 30),
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
                                              'New Stores',
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
                                              returnResourceProvider(
                                                    context:
                                                        context,
                                                  ).hideMoneyDashBoard
                                                  ? '***'
                                                  : returnShopProvider(
                                                      context:
                                                          context,
                                                    ).getThisMonthRegisteredStores().length.toString(),
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
                                              'Subscribed Stores',
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
                                              returnResourceProvider(
                                                    context:
                                                        context,
                                                  ).hideMoneyDashBoard
                                                  ? '***'
                                                  : returnShopProvider(
                                                      context:
                                                          context,
                                                    ).getThisMonthSubscribedShops().length.toString(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height:isMobileSmall(context) ? 25 : 30),
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
                                              'Total Headquarters',
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
                                              returnResourceProvider(
                                                    context:
                                                        context,
                                                  ).hideMoneyDashBoard
                                                  ? '***'
                                                  : returnShopProvider(
                                                      context:
                                                          context,
                                                    ).shopInfos.length.toString(),
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
                                              returnResourceProvider(
                                                    context:
                                                        context,
                                                  ).hideMoneyDashBoard
                                                  ? '***'
                                                  : 200.toString(),
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

 */
