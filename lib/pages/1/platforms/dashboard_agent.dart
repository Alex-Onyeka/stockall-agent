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
                  return returnShopProvider(
                    context: context,
                    listen: false,
                  ).getShops(context);
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
                                          'Balance',
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
                                                  returnUserProvider(
                                                                context: context,
                                                                listen: false,
                                                              ).currentUser?.role ==
                                                          'Freelance'
                                                      ? returnSubscriptionProvider(
                                                          context: context,
                                                        ).getCut(
                                                          context,
                                                          returnUserProvider(
                                                            context: context,
                                                          ).currentUser!.userId!,
                                                          returnUserProvider(
                                                            context: context,
                                                          ).currentUser!.role!,
                                                        )
                                                      : ((returnSubPaymentsProvider(
                                                              context: context,
                                                            ).getAgentsCutForMonthsPayment(
                                                              returnUserProvider(
                                                                    context: context,
                                                                    listen: false,
                                                                  ).currentUser?.referralCode ??
                                                                  '',
                                                              returnUserProvider(
                                                                context: context,
                                                                listen: false,
                                                              ).currentUser!.role!,
                                                              context,
                                                            ) +
                                                            getAgentsSalary(
                                                              returnShopProvider(
                                                                    context: context,
                                                                    listen: false,
                                                                  )
                                                                  .getHeadQuaters()
                                                                  .where(
                                                                    (
                                                                      sh,
                                                                    ) =>
                                                                        sh.refCode ==
                                                                            returnUserProvider(
                                                                                  context: context,
                                                                                  listen: false,
                                                                                ).currentUser?.referralCode &&
                                                                        (sh.createdAt.isAfter(
                                                                              monthStart(),
                                                                            ) ||
                                                                            sh.createdAt.isAtSameMomentAs(
                                                                              monthStart(),
                                                                            )),
                                                                  )
                                                                  .length,
                                                            ))),
                                                ),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        returnResourceProvider(
                                          context: context,
                                          listen: false,
                                        ).toggleHideMoney();
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
                                Divider(height: 30),
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
                                              'Subscribed Stores',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .h4
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
                                                    ).getThisMonthSubscribedShops(context).length.toString(),
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
                                              'Month\'s Subscription',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize: theme
                                                    .mobileTexts
                                                    .h4
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
                                                  : formatMoney(
                                                      returnSubscriptionProvider(
                                                        context:
                                                            context,
                                                      ).totalMoney(),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(height: 30),
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
                                                    .h4
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
                                                    ).getHeadQuaters().length.toString(),
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
                                              'This Month',
                                            ),
                                            Text(
                                              style: TextStyle(
                                                color: Colors
                                                    .white,
                                                fontSize: theme
                                                    .mobileTexts
                                                    .h4
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
                                                    ).getThisMonthRegisteredStores().length.toString(),
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
                              1.5,
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
                      height:
                          returnShopProvider(
                                    context: context,
                                  )
                                  .getThisMonthRegisteredStores()
                                  .length <
                              2
                          ? MediaQuery.of(
                                  context,
                                ).size.height -
                                390
                          : (100 +
                                    (98 *
                                        returnShopProvider(
                                              context:
                                                  context,
                                            )
                                            .getThisMonthRegisteredStores()
                                            .length))
                                .toDouble(),
                      padding: EdgeInsets.all(20),
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(
                                      left: 0.0,
                                    ),
                                child: Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b1
                                        .fontSize,
                                    color: Colors.white,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                  'Recent Stores',
                                ),
                              ),
                              InkWell(
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
                            height: 10,
                            color: Colors.white38,
                          ),
                          Builder(
                            builder: (context) {
                              if (returnShopProvider(
                                    context: context,
                                  )
                                  .getThisMonthRegisteredStores()
                                  .isEmpty) {
                                return Expanded(
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
