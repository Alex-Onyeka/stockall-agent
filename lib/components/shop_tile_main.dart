import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_class.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class ShopTileMain extends StatelessWidget {
  final ShopClass shop;
  const ShopTileMain({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Row(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: Text(
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.b1.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        shop.name,
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b2.fontSize,
                        // color: theme
                        //     .lightModeColor
                        //     .secColor200,
                        fontWeight: FontWeight.bold,
                      ),
                      formatMoney(
                        returnSubscriptionProvider(
                          context: context,
                        ).getShopSubscriptionAmount(
                          shop.userId,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                  color: Colors.grey.shade100,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
                            fontWeight: FontWeight.normal,
                          ),
                          'Plan: ',
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b3
                                .fontSize,
                            color:
                                returnSubscriptionProvider(
                                      context: context,
                                    ).getSubscriptionPlan(
                                      shop.userId,
                                    ) ==
                                    0
                                ? Colors.redAccent
                                : null,
                            fontWeight: FontWeight.bold,
                          ),
                          returnSubscriptionProvider(
                            context: context,
                          ).getSubscriptionPlanName(
                            shop.userId,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b4
                                .fontSize,
                            fontWeight: FontWeight.normal,
                          ),
                          'Your Cut: ',
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b3
                                .fontSize,
                            color:
                                returnSubscriptionProvider(
                                      context: context,
                                    ).getSubscriptionPlan(
                                      shop.userId,
                                    ) !=
                                    0
                                ? const Color.fromARGB(
                                    255,
                                    66,
                                    170,
                                    69,
                                  )
                                : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          formatMoney(
                            returnSubscriptionProvider(
                                  context: context,
                                ).getShopSubscriptionAmount(
                                  shop.userId,
                                ) *
                                referralCut,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
