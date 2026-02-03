import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_class.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';

class ShopTileMain extends StatelessWidget {
  final ShopClass shop;
  final bool? isReport;
  const ShopTileMain({
    super.key,
    required this.shop,
    this.isReport,
  });

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
        boxShadow: isReport != null
            ? [
                BoxShadow(
                  color: const Color.fromARGB(31, 0, 0, 0),
                  blurRadius: 10,
                ),
              ]
            : null,
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
                        shop.name.toUpperCase(),
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b3.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      returnSubscriptionProvider(
                                    context: context,
                                  ).getShopSubscriptionAmount(
                                    shop.userId,
                                  ) ==
                                  0 &&
                              returnSubscriptionProvider(
                                    context: context,
                                  ).getShopSubscriptionPlan(
                                    shop.userId,
                                  ) ==
                                  3
                          ? 'Trial Plan'
                          : formatMoney(
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
                    Builder(
                      builder: (context) {
                        if (shop.isHeadQuaters) {
                          return Row(
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
                                      .b4
                                      .fontSize,
                                  color:
                                      returnSubscriptionProvider(
                                            context:
                                                context,
                                          ).getShopSubscriptionPlan(
                                            shop.userId,
                                          ) ==
                                          0
                                      ? Colors.redAccent
                                      : null,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                                returnSubscriptionProvider(
                                              context:
                                                  context,
                                            ).getShopSubscriptionAmount(
                                              shop.userId,
                                            ) ==
                                            0 &&
                                        returnSubscriptionProvider(
                                              context:
                                                  context,
                                            ).getShopSubscriptionPlan(
                                              shop.userId,
                                            ) ==
                                            3
                                    ? 'Trial Plan'
                                    : returnSubscriptionProvider(
                                        context: context,
                                      ).getShopSubscriptionPlanName(
                                        shop.userId,
                                      ),
                              ),
                            ],
                          );
                        } else {
                          return Text(
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b4
                                  .fontSize,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            'Branch Store',
                          );
                        }
                      },
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
                          shop.isHeadQuaters
                              ? returnAdminProvider(
                                          context: context,
                                        ).admin ==
                                        null
                                    ? 'Your Cut: '
                                    : 'Expiry Date: '
                              : 'Headquater: ',
                        ),
                        Text(
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b4
                                .fontSize,
                            color: shop.isHeadQuaters
                                ? returnAdminProvider(
                                            context:
                                                context,
                                          ).admin ==
                                          null
                                      ? returnSubscriptionProvider(
                                                  context:
                                                      context,
                                                ).getShopSubscriptionPlan(
                                                  shop.userId,
                                                ) !=
                                                0
                                            ? const Color.fromARGB(
                                                255,
                                                66,
                                                170,
                                                69,
                                              )
                                            : Colors.grey
                                      : Colors.grey
                                : Colors.grey.shade900,
                            fontWeight: FontWeight.bold,
                          ),
                          shop.isHeadQuaters
                              ? returnAdminProvider(
                                          context: context,
                                        ).admin ==
                                        null
                                    ? formatMoney(
                                        returnSubscriptionProvider(
                                              context:
                                                  context,
                                            ).getShopSubscriptionAmount(
                                              shop.userId,
                                            ) *
                                            referralCut(
                                              returnUserProvider(
                                                context:
                                                    context,
                                                listen:
                                                    false,
                                              ).currentUser!.role!,
                                            ),
                                      )
                                    : formatDateShort(
                                            returnSubscriptionProvider(
                                                  context:
                                                      context,
                                                )
                                                .getShopSubscription(
                                                  shop.userId,
                                                )
                                                .nextPayment,
                                          ) ??
                                          'Not Set'
                              : returnShopProvider(
                                      context: context,
                                    ).shops
                                    .firstWhere(
                                      (sh) =>
                                          sh.isHeadQuaters &&
                                          sh.userId ==
                                              shop.userId,
                                    )
                                    .name,
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
