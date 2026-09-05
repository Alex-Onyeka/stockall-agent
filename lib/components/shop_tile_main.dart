import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/shop_page/shop_page.dart';

class ShopTileMain extends StatelessWidget {
  final ShopInfo shop;
  final bool? isReport;
  const ShopTileMain({
    super.key,
    required this.shop,
    this.isReport,
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
                              child: Text(
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b3
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                                shop.shopName.toUpperCase(),
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
                            Visibility(
                              visible:
                                  ((shop.remainingDays ??
                                          0) <
                                      30) &&
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
                                          FontWeight.normal,
                                    ),
                                    (shop.remainingDays ??
                                                0) <
                                            0
                                        ? 'Expired'
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
                                          FontWeight.bold,
                                    ),

                                    shop.getRemainingDays(),
                                  ),
                                ],
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
          ),
        ),
      ),
    );
  }
}
