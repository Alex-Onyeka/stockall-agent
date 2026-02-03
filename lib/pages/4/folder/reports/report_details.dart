import 'package:flutter/material.dart';
import 'package:stockallagent/classes/report_class.dart';
import 'package:stockallagent/components/empty_widget.dart';
import 'package:stockallagent/components/shop_tile_main.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class ReportDetails extends StatelessWidget {
  final ReportClass report;
  const ReportDetails({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding:
                            EdgeInsetsGeometry.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                        child: Icon(
                          size: 20,
                          color: Colors.grey.shade600,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b1.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    '${getMonthAndYear(report.date)} Details',
                  ),
                  Opacity(
                    opacity: 0,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding:
                              EdgeInsetsGeometry.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                          child: Icon(
                            size: 20,
                            color: Colors.grey.shade600,
                            Icons
                                .arrow_back_ios_new_rounded,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                padding: const EdgeInsets.symmetric(
                  // horizontal: 20.0,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
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
                                                  report
                                                      .totalNet,
                                                ),
                                        ),
                                      ],
                                    ),
                                    // InkWell(
                                    //   onTap: () {
                                    //     returnResourceProvider(
                                    //       context: context,
                                    //       listen: false,
                                    //     ).toggleHideMoney();
                                    //   },
                                    //   child: Icon(
                                    //     color: Colors.white,
                                    //     returnResourceProvider(
                                    //           context:
                                    //               context,
                                    //         ).hideMoneyDashBoard
                                    //         ? Icons
                                    //               .desktop_access_disabled_rounded
                                    //         : Icons
                                    //               .desktop_mac_rounded,
                                    //   ),
                                    // ),
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
                                              'Total Revenue',
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
                                              formatMoney(
                                                report
                                                    .totalRevenue,
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
                                              'Referrals Cut',
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
                                              formatMoney(
                                                report
                                                    .totalRefCut,
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
                                              'New Stores',
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
                                              report
                                                  .newStores
                                                  .toString(),
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
                                                    .h4
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                              ),
                                              report
                                                  .subscribedStores
                                                  .toString(),
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
                                              'Total Headquarters',
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
                                              report
                                                  .totalHeadQuarters
                                                  .toString(),
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
                                                    .h4
                                                    .fontSize,
                                                fontWeight:
                                                    FontWeight
                                                        .bold,
                                                color: Colors
                                                    .white,
                                              ),
                                              report
                                                  .totalStores
                                                  .toString(),
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
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: report.newStoresId.length < 2
                          ? MediaQuery.of(
                                  context,
                                ).size.height -
                                390
                          : (100 +
                                    (98 *
                                        (report
                                            .newStoresId
                                            .length)))
                                .toDouble(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
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
                                      .b1
                                      .fontSize,
                                  color:
                                      Colors.grey.shade800,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                                'New Stores',
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          Builder(
                            builder: (context) {
                              if (report
                                  .newStoresId
                                  .isEmpty) {
                                return Expanded(
                                  child: EmptyWidget(
                                    isDashboard: false,
                                  ),
                                );
                              } else {
                                return Column(
                                  spacing: 0,
                                  children: report.newStoresId.map((
                                    sho,
                                  ) {
                                    var newSh =
                                        returnShopProvider(
                                          context: context,
                                          listen: false,
                                        ).shops.firstWhere(
                                          (sh) =>
                                              sh.shopId ==
                                              sho,
                                        );
                                    return ShopTileMain(
                                      isReport: true,
                                      shop: newSh,
                                    );
                                  }).toList(),
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
