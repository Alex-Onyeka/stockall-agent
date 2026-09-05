import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class ReportDetails extends StatelessWidget {
  final AnalysisReport report;
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
                      mouseCursor: SystemMouseCursors.click,
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
                    '${getMonthAndYear(report.createdAt)} Details',
                  ),
                  Opacity(
                    opacity: 0,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        mouseCursor:
                            SystemMouseCursors.click,
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
                    // ClipRRect(
                    //   clipBehavior: Clip.hardEdge,
                    //   child: Stack(
                    //     children: [
                    //       Container(
                    //         padding: EdgeInsets.symmetric(
                    //           vertical: 20,
                    //           horizontal: 20,
                    //         ),
                    //         decoration: BoxDecoration(
                    //           borderRadius:
                    //               BorderRadius.circular(10),
                    //           color: const Color.fromARGB(
                    //             255,
                    //             1,
                    //             29,
                    //             53,
                    //           ),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color:
                    //                   const Color.fromARGB(
                    //                     5,
                    //                     0,
                    //                     0,
                    //                     0,
                    //                   ),
                    //               blurRadius: 10,
                    //             ),
                    //           ],
                    //         ),
                    //         child: Column(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.center,
                    //           children: [
                    //             Row(
                    //               spacing: 10,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment
                    //                       .spaceBetween,
                    //               children: [
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Total Stores',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             report
                    //                                 .getTotalShops(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Headquaters',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             report.totalShopsMain
                    //                                     ?.toDouble() ??
                    //                                 0,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             color: Colors
                    //                                 .white,
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                           ),
                    //                           'Branches',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             color: Colors
                    //                                 .white,
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                           ),
                    //                           formatNumber(
                    //                             (report.totalShopsBranches ??
                    //                                     0)
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Divider(
                    //               height:
                    //                   isMobileSmall(context)
                    //                   ? 25
                    //                   : 30,
                    //             ),
                    //             Row(
                    //               spacing: 10,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment
                    //                       .spaceBetween,
                    //               children: [
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Total Subsc.',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             report.totalSubscriptions
                    //                                     ?.toDouble() ??
                    //                                 0,
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Subsc. Today',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTodaysSubscribedShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             color: Colors
                    //                                 .white,
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                           ),
                    //                           'New Stores',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             color: Colors
                    //                                 .white,
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTodaysRegisteredStores()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Divider(
                    //               height:
                    //                   isMobileSmall(context)
                    //                   ? 25
                    //                   : 30,
                    //             ),
                    //             Row(
                    //               spacing: 10,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment
                    //                       .spaceBetween,
                    //               children: [
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Total Trial',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTotalTrialShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Total Free',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTotalFreeShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Total Expired',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTotalExpiredShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             Divider(
                    //               height:
                    //                   isMobileSmall(context)
                    //                   ? 25
                    //                   : 30,
                    //             ),
                    //             Row(
                    //               spacing: 10,
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment
                    //                       .spaceBetween,
                    //               children: [
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Active',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTotalActiveShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Semi Active',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTotalSemiActiveShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 Container(
                    //                   height: 50,
                    //                   width: 1,
                    //                   color: Colors
                    //                       .grey
                    //                       .shade400,
                    //                 ),
                    //                 Expanded(
                    //                   child: SizedBox(
                    //                     // width: 110,
                    //                     child: Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment
                    //                               .start,
                    //                       spacing: 5,
                    //                       children: [
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b4
                    //                                 .fontSize,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           'Inactive',
                    //                         ),
                    //                         Text(
                    //                           style: TextStyle(
                    //                             fontSize: theme
                    //                                 .mobileTexts
                    //                                 .b2
                    //                                 .fontSize,
                    //                             fontWeight:
                    //                                 FontWeight
                    //                                     .bold,
                    //                             color: Colors
                    //                                 .white,
                    //                           ),
                    //                           formatNumber(
                    //                             shopProv
                    //                                 .getTotalInActiveShops()
                    //                                 .length
                    //                                 .toDouble(),
                    //                           ),
                    //                         ),
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Align(
                    //         alignment: AlignmentGeometry.xy(
                    //           -1.4,
                    //           0,
                    //         ),
                    //         child: Container(
                    //           height: 140,
                    //           width: 140,
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: const Color.fromARGB(
                    //               15,
                    //               255,
                    //               255,
                    //               255,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // Container(
                    //   height: (report.totalActive ?? 0) < 2
                    //       ? MediaQuery.of(
                    //               context,
                    //             ).size.height -
                    //             390
                    //       : (100 +
                    //                 (98 *
                    //                     (report.totalActive ??
                    //                         0)))
                    //             .toDouble(),
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 5,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white10,
                    //     borderRadius: BorderRadius.vertical(
                    //       top: Radius.circular(20),
                    //     ),
                    //   ),
                    //   child: Column(
                    //     spacing: 10,
                    //     children: [
                    //       Row(
                    //         mainAxisAlignment:
                    //             MainAxisAlignment
                    //                 .spaceBetween,
                    //         children: [
                    //           Text(
                    //             style: TextStyle(
                    //               fontSize: theme
                    //                   .mobileTexts
                    //                   .b1
                    //                   .fontSize,
                    //               color:
                    //                   Colors.grey.shade800,
                    //               fontWeight:
                    //                   FontWeight.bold,
                    //             ),
                    //             'New Stores',
                    //           ),
                    //         ],
                    //       ),
                    //       Divider(
                    //         height: 1,
                    //         color: Colors.grey.shade300,
                    //       ),
                    //       Builder(
                    //         builder: (context) {
                    //           if (report.totalActive == 0) {
                    //             return Expanded(
                    //               child: EmptyWidget(
                    //                 isDashboard: false,
                    //               ),
                    //             );
                    //           } else {
                    //             return Column(
                    //               spacing: 0,
                    //               children: report
                    //                   .totalActiveList
                    //                   .map((sho) {
                    //                     var newSh =
                    //                         returnShopProvider()
                    //                             .shopInfos
                    //                             .firstWhere(
                    //                               (sh) =>
                    //                                   sh.shopId ==
                    //                                   sho,
                    //                             );
                    //                     return ShopTileMain(
                    //                       isReport: true,
                    //                       shop: newSh,
                    //                     );
                    //                   })
                    //                   .toList(),
                    //             );
                    //           }
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 20),
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
