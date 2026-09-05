import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/shop_page/shop_page.dart';

class ShopTileMain extends StatelessWidget {
  final ShopInfo shop;
  final bool? isReport;
  final int? sortInt;
  const ShopTileMain({
    super.key,
    required this.shop,
    this.isReport,
    this.sortInt,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: isReport != null
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(
                        31,
                        0,
                        0,
                        0,
                      ),
                      blurRadius: 10,
                    ),
                  ]
                : null,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ShopPage(
                      shopId: shop.shopId.toInt(),
                    );
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                boxShadow: isReport != null
                    ? [
                        BoxShadow(
                          color: const Color.fromARGB(
                            31,
                            0,
                            0,
                            0,
                          ),
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                spacing: 10,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          spacing: 5,
                          children: [
                            Expanded(
                              child: Column(
                                spacing: 3,
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: theme
                                          .mobileTexts
                                          .b3
                                          .fontSize,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                    shop.shopName
                                        .toUpperCase(),
                                  ),
                                  Row(
                                    spacing: 8,
                                    children: [
                                      Row(
                                        spacing: 5,
                                        children: [
                                          Text(
                                            style: TextStyle(
                                              fontSize: theme
                                                  .mobileTexts
                                                  .b4
                                                  .fontSize,
                                              fontWeight:
                                                  FontWeight
                                                      .normal,
                                              color: Colors
                                                  .grey,
                                            ),
                                            'Owner:',
                                          ),
                                          Text(
                                            style: TextStyle(
                                              fontSize: theme
                                                  .mobileTexts
                                                  .b5
                                                  .fontSize,
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                              color: Colors
                                                  .grey,
                                            ),
                                            (shop.userName ??
                                                    'Not Set')
                                                .toUpperCase(),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b5
                                              .fontSize,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                          color:
                                              Colors.grey,
                                        ),
                                        '|',
                                      ),
                                      Row(
                                        spacing: 5,
                                        children: [
                                          Text(
                                            style: TextStyle(
                                              fontSize: theme
                                                  .mobileTexts
                                                  .b4
                                                  .fontSize,
                                              fontWeight:
                                                  FontWeight
                                                      .normal,
                                              color: Colors
                                                  .grey,
                                            ),
                                            'Agent:',
                                          ),
                                          Text(
                                            style: TextStyle(
                                              fontSize: theme
                                                  .mobileTexts
                                                  .b5
                                                  .fontSize,
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                              color: Colors
                                                  .grey,
                                            ),
                                            (shop.agentLastName ??
                                                    'Not Set')
                                                .toUpperCase(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              size: 17,
                              color: Colors.grey.shade300,
                              Icons
                                  .arrow_forward_ios_rounded,
                            ),
                          ],
                        ),
                        Divider(
                          height: 15,
                          color: Colors.grey.shade100,
                        ),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .spaceBetween,
                          spacing: 5,
                          children: [
                            Row(
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b4
                                        .fontSize,
                                    fontWeight:
                                        FontWeight.normal,
                                  ),
                                  'Plan: ',
                                ),
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b5
                                        .fontSize,
                                    color:
                                        shop
                                            .expiredColor() ??
                                        Colors
                                            .grey
                                            .shade800,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                  shop
                                      .currentPlanName()
                                      .toUpperCase(),
                                ),
                              ],
                            ),
                            Builder(
                              builder: (context) {
                                if (sortInt == null ||
                                    sortInt == 4) {
                                  return Visibility(
                                    visible:
                                        shop.subscriptionNextPayment !=
                                        null,
                                    child: Row(
                                      spacing: 4,
                                      children: [
                                        Text(
                                          style: TextStyle(
                                            fontSize: theme
                                                .mobileTexts
                                                .b4
                                                .fontSize,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                          ),
                                          (shop.remainingDays ??
                                                      0) <
                                                  0
                                              ? 'Expired:'
                                              : 'Expires In:',
                                        ),
                                        Text(
                                          style: TextStyle(
                                            fontSize: theme
                                                .mobileTexts
                                                .b4
                                                .fontSize,
                                            color: Colors
                                                .grey
                                                .shade900,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),

                                          shop.getRemainingDays(),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (sortInt == 2) {
                                  return Row(
                                    spacing: 4,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b4
                                              .fontSize,
                                          fontWeight:
                                              FontWeight
                                                  .normal,
                                        ),
                                        'Created At:',
                                      ),
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b4
                                              .fontSize,
                                          color: Colors
                                              .grey
                                              .shade900,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),

                                        formatDate(
                                          shop.shopCreatedAt,
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (sortInt == 3) {
                                  return Row(
                                    spacing: 4,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b4
                                              .fontSize,
                                          fontWeight:
                                              FontWeight
                                                  .normal,
                                        ),
                                        'Last Seen:',
                                      ),
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b4
                                              .fontSize,
                                          color: Colors
                                              .grey
                                              .shade900,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),

                                        shop.getLastSeen(),
                                      ),
                                    ],
                                  );
                                } else if (sortInt == 5) {
                                  return Row(
                                    spacing: 4,
                                    children: [
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b4
                                              .fontSize,
                                          fontWeight:
                                              FontWeight
                                                  .normal,
                                        ),
                                        'Subscribed:',
                                      ),
                                      Text(
                                        style: TextStyle(
                                          fontSize: theme
                                              .mobileTexts
                                              .b4
                                              .fontSize,
                                          color: Colors
                                              .grey
                                              .shade900,
                                          fontWeight:
                                              FontWeight
                                                  .bold,
                                        ),

                                        shop.getSubscribedDate(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Visibility(
                                    visible:
                                        shop.subscriptionNextPayment !=
                                        null,
                                    child: Row(
                                      spacing: 4,
                                      children: [
                                        Text(
                                          style: TextStyle(
                                            fontSize: theme
                                                .mobileTexts
                                                .b4
                                                .fontSize,
                                            fontWeight:
                                                FontWeight
                                                    .normal,
                                          ),
                                          (shop.remainingDays ??
                                                      0) <
                                                  0
                                              ? 'Expired:'
                                              : 'Expires In:',
                                        ),
                                        Text(
                                          style: TextStyle(
                                            fontSize: theme
                                                .mobileTexts
                                                .b4
                                                .fontSize,
                                            color: Colors
                                                .grey
                                                .shade900,
                                            fontWeight:
                                                FontWeight
                                                    .bold,
                                          ),

                                          shop.getRemainingDays(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
