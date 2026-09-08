import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/shop_info.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/shop_page/components/agent_details_section.dart';
import 'package:stockallagent/pages/shop_page/components/comments_list_widget.dart';
import 'package:stockallagent/pages/shop_page/components/operations_details_section.dart';
import 'package:stockallagent/pages/shop_page/components/owners_details_section.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_main_section.dart';
import 'package:stockallagent/pages/shop_page/components/shop_details_section.dart';
import 'package:stockallagent/pages/shop_page/components/subscription_details_section.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class ShopPage extends StatelessWidget {
  final int shopId;
  const ShopPage({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    ShopInfo shop = returnShopProvider(
      context: context,
    ).shopInfos.firstWhere((item) => item.shopId == shopId);
    var theme = returnTheme();
    return Scaffold(
      backgroundColor: const Color.fromARGB(
        255,
        255,
        255,
        255,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
            decoration: BoxDecoration(
              color: theme.lightModeColor.prColor300,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      mouseCursor: SystemMouseCursors.click,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        color: Colors.grey.shade200,
                        size: 20,
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b2.fontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      'Shop Details',
                    ),
                    Opacity(
                      opacity: 0,
                      child: IconButton(
                        mouseCursor:
                            SystemMouseCursors.click,
                        onPressed: () {},
                        icon: Icon(
                          color: Colors.white,
                          size: 20,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: const Color.fromARGB(
                    80,
                    158,
                    158,
                    158,
                  ),
                ),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () {
                      print('Copying shit');
                      Clipboard.setData(
                        ClipboardData(text: shop.shopName),
                      );

                      showSnackbar(
                        message:
                            'Shop Name been copied to clipboard.',
                        title: 'Copied to Clipboard!',
                        context: context,
                        actionResult:
                            ActionResult().success,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        10,
                        10,
                        10,
                        10,
                      ),
                      child: Column(
                        spacing: 5,
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Icon(
                                size: 25,
                                color: shop.isDeleted
                                    ? Colors.grey
                                    : Colors.amber,
                                shop.isDeleted
                                    ? Icons.clear
                                    : Icons
                                          .home_work_outlined,
                              ),
                              Visibility(
                                visible: shop.isDeleted,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(
                                        left: 5.0,
                                      ),
                                  child: Text(
                                    textAlign:
                                        TextAlign.center,
                                    style: TextStyle(
                                      fontSize: theme
                                          .mobileTexts
                                          .b5
                                          .fontSize,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors
                                          .grey
                                          .shade400,
                                    ),
                                    'Deleted',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .h4
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            shop.shopName.toUpperCase(),
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b5
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.normal,
                                  color:
                                      Colors.grey.shade400,
                                ),
                                "STATUS:",
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b5
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Colors.grey.shade400,
                                ),
                                shop.activeText(),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: shop.activeColor(),
                                ),
                                padding: EdgeInsets.all(4),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            spacing: 5,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b5
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.normal,
                                  color:
                                      Colors.grey.shade400,
                                ),
                                "Last Seen:".toUpperCase(),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b5
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.bold,
                                  color:
                                      Colors.grey.shade400,
                                ),
                                shop.getLastSeen(),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                15.0,
                15,
                15,
                50,
              ),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  children: [
                    Visibility(
                      visible: mainAdmin()
                          ? true
                          : currentUser().userId !=
                                shop.agentUuid,
                      child: Builder(
                        builder: (context) {
                          if (shop.agentEmail != null) {
                            return ShopDetailsMainSection(
                              title: 'Agent Details',
                              shop: shop,
                              widgett: AgentDetailsSection(
                                shop: shop,
                              ),
                            );
                          } else {
                            return EmptyAgentWidget(
                              shop: shop,
                              theme: theme,
                            );
                          }
                        },
                      ),
                    ),
                    Visibility(
                      visible: shop.agentEmail != null,
                      child: ShopDetailsMainSection(
                        title: 'Comments',
                        shop: shop,
                        widgett: CommentsListWidget(
                          shop: shop,
                        ),
                      ),
                    ),
                    ShopDetailsMainSection(
                      title: 'Shop Details',
                      shop: shop,
                      widgett: ShopDetailsSection(
                        shop: shop,
                      ),
                    ),
                    ShopDetailsMainSection(
                      title: 'Owners Details',
                      shop: shop,
                      widgett: OwnersDetailsSection(
                        shop: shop,
                      ),
                    ),
                    ShopDetailsMainSection(
                      title: 'Subscription Details',
                      shop: shop,
                      widgett: SubscriptionDetailsSection(
                        shop: shop,
                      ),
                    ),
                    ShopDetailsMainSection(
                      title: 'Other Operations',
                      shop: shop,
                      widgett: OperationsDetailsSection(
                        shop: shop,
                      ),
                    ),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: !shop.isDeleted,
                          child: Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(
                                    right: 10.0,
                                  ),
                              child: Material(
                                color: Colors.transparent,
                                child: Ink(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(
                                          3,
                                        ),
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    color: Colors
                                        .grey
                                        .shade100,
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (!returnShopProvider()
                                          .isLoading) {
                                        showDialog(
                                          context: context,
                                          builder: (firstContext) {
                                            return DialogTemplate(
                                              mainWidget: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                      0,
                                                      20,
                                                      0,
                                                      0,
                                                    ),
                                                child: Column(
                                                  spacing:
                                                      10,
                                                  children: [
                                                    ImportanceListTileWidget(
                                                      index:
                                                          1,
                                                      shop:
                                                          shop,
                                                      theme:
                                                          theme,
                                                      title:
                                                          'Important',
                                                      value:
                                                          shop.isImportant,
                                                    ),
                                                    ImportanceListTileWidget(
                                                      index:
                                                          2,
                                                      shop:
                                                          shop,
                                                      theme:
                                                          theme,
                                                      title:
                                                          'Importanter',
                                                      value:
                                                          shop.isImportanter,
                                                    ),
                                                    ImportanceListTileWidget(
                                                      index:
                                                          3,
                                                      shop:
                                                          shop,
                                                      theme:
                                                          theme,
                                                      title:
                                                          'Importantest',
                                                      value:
                                                          shop.isImportantest,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              title:
                                                  (shop.isImportant ||
                                                      shop.isImportanter ||
                                                      shop.isImportantest)
                                                  ? "Cancel Importance"
                                                  : 'Set Importance',

                                              message:
                                                  'You are about to ${(shop.isImportant || shop.isImportanter || shop.isImportantest) ? 'Cancel Importance' : 'Set Importance'} of This business. Are you sure you want to proceed?',
                                            );
                                          },
                                        );
                                      }
                                    },
                                    mouseCursor:
                                        SystemMouseCursors
                                            .click,
                                    child: Container(
                                      constraints:
                                          BoxConstraints(
                                            maxWidth: 300,
                                          ),
                                      padding:
                                          EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 10,
                                          ),

                                      child: Builder(
                                        builder: (context) {
                                          if (returnShopProvider()
                                              .isLoading) {
                                            return Center(
                                              child: SizedBox(
                                                height: 23,
                                                width: 23,
                                                child: CircularProgressIndicator(
                                                  color: Colors
                                                      .amber,
                                                  strokeWidth:
                                                      2,
                                                ),
                                              ),
                                            );
                                          } else {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .center,
                                              spacing: 4,
                                              children: [
                                                Text(
                                                  style: TextStyle(
                                                    fontSize: theme
                                                        .mobileTexts
                                                        .b3
                                                        .fontSize,
                                                  ),
                                                  shop.isImportant
                                                      ? 'Important'
                                                      : shop.isImportanter
                                                      ? 'Importanter'
                                                      : shop.isImportantest
                                                      ? 'Importantest'
                                                      : 'Set Importance',
                                                ),
                                                Icon(
                                                  size: 20,
                                                  color: Colors
                                                      .grey,
                                                  (shop.isImportant ||
                                                          shop.isImportanter ||
                                                          shop.isImportantest)
                                                      ? Icons.clear
                                                      : Icons.check,
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(
                                      3,
                                    ),
                                border: Border.all(
                                  color: shop.isDeleted
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                ),
                                color: shop.isDeleted
                                    ? const Color.fromARGB(
                                        19,
                                        162,
                                        244,
                                        54,
                                      )
                                    : const Color.fromARGB(
                                        20,
                                        244,
                                        67,
                                        54,
                                      ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (!returnShopProvider()
                                      .isLoading) {
                                    showDialog(
                                      context: context,
                                      builder: (firstContext) {
                                        return DialogTemplate(
                                          title:
                                              shop.isDeleted
                                              ? "Restore Shop"
                                              : 'Mark As Deleted',
                                          action: () async {
                                            Navigator.of(
                                              firstContext,
                                            ).pop();
                                            await returnShopProvider().setBusinessBoolValues(
                                              isDelete: !shop
                                                  .isDeleted,
                                              shopId: shop
                                                  .shopId
                                                  .toInt(),
                                              uuidd: shop
                                                  .agentAndShopUuid!,
                                            );
                                          },
                                          message:
                                              'You are about to Mark This business as deleted. Are you sure you want to proceed?',
                                        );
                                      },
                                    );
                                  }
                                },
                                mouseCursor:
                                    SystemMouseCursors
                                        .click,
                                child: Container(
                                  constraints:
                                      BoxConstraints(
                                        maxWidth: 300,
                                      ),
                                  padding:
                                      EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 10,
                                      ),

                                  child: Builder(
                                    builder: (context) {
                                      if (returnShopProvider()
                                          .isLoading) {
                                        return Center(
                                          child: SizedBox(
                                            height: 23,
                                            width: 23,
                                            child: CircularProgressIndicator(
                                              color: Colors
                                                  .amber,
                                              strokeWidth:
                                                  2,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                          spacing: 4,
                                          children: [
                                            Text(
                                              style: TextStyle(
                                                fontSize: theme
                                                    .mobileTexts
                                                    .b3
                                                    .fontSize,
                                              ),
                                              shop.isDeleted
                                                  ? 'Restore Shop'
                                                  : 'Mark As Deleted',
                                            ),
                                            Icon(
                                              size: 20,
                                              color:
                                                  shop.isDeleted
                                                  ? Colors
                                                        .green
                                                  : Colors
                                                        .red,
                                              shop.isDeleted
                                                  ? Icons
                                                        .check
                                                  : Icons
                                                        .delete_forever_outlined,
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class ImportanceListTileWidget extends StatelessWidget {
  const ImportanceListTileWidget({
    super.key,
    required this.theme,
    required this.title,
    required this.value,
    required this.index,
    required this.shop,
  });

  final ThemeProvider theme;
  final String title;
  final bool value;
  final ShopInfo shop;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: InkWell(
          onTap: () async {
            Navigator.of(context).pop();
            await returnShopProvider()
                .setBusinessBoolValues(
                  isImportant: index == 1 ? !value : null,
                  isImportanter: index == 2 ? !value : null,
                  isImportantest: index == 3
                      ? !value
                      : null,
                  shopId: shop.shopId.toInt(),
                  uuidd: shop.agentAndShopUuid!,
                );
          },
          mouseCursor: SystemMouseCursors.click,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                Text(
                  style: TextStyle(
                    fontSize: theme.mobileTexts.b3.fontSize,
                  ),
                  "${value ? 'Cancel' : 'Set As'} $title",
                ),
                Visibility(
                  visible: value,
                  child: Icon(size: 20, Icons.check),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyAgentWidget extends StatelessWidget {
  const EmptyAgentWidget({
    super.key,
    required this.shop,
    required this.theme,
  });

  final ShopInfo shop;
  final ThemeProvider theme;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: topAdmin(),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(28, 0, 0, 0),
                blurRadius: 10,
              ),
            ],
          ),
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () {
              if (!returnShopProvider().isLoading &&
                  topAdmin()) {
                addAgentAction(
                  context: context,
                  shop: shop,
                );
              }
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),

              child: Center(
                child: Builder(
                  builder: (context) {
                    if (returnShopProvider(
                      context: context,
                    ).isLoading) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 5,
                        children: [
                          Icon(
                            size: 20,
                            color: theme
                                .lightModeColor
                                .tertColor200,
                            Icons.person_add_alt_1_outlined,
                          ),
                          Text(
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b3
                                  .fontSize,
                            ),
                            'Add Agent',
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void addAgentAction({
  required BuildContext context,
  required ShopInfo shop,
}) {
  var theme = returnTheme();
  showDialog(
    context: context,
    builder: (firstContext) {
      return DialogTemplate(
        title: 'Select Agent',
        subTitle:
            'Select An Agent from the List to Manage this Business',
        mainWidget: Column(
          spacing: 5,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...returnUserProvider().agents
                .where((item) => item.roleId == 1)
                .map(
                  (item) => AddAgentToStoreWidgetTile(
                    theme: theme,
                    user: item,
                    shop: shop,
                  ),
                ),
            AddAgentToStoreWidgetTile(
              theme: theme,
              user: currentUser(),
              shop: shop,
            ),
          ],
        ),
      );
    },
  );
}

class AddAgentToStoreWidgetTile extends StatelessWidget {
  const AddAgentToStoreWidgetTile({
    super.key,
    required this.theme,
    required this.shop,
    required this.user,
  });

  final ThemeProvider theme;
  final ShopInfo shop;
  final UserClass user;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
        ),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (firstContext) {
                return DialogTemplate(
                  title: 'Assign Agent',
                  action: () async {
                    Navigator.of(firstContext).pop();
                    Navigator.of(context).pop();
                    await returnShopProvider().setAgent(
                      shopName: shop.shopName,
                      uuid: shop.agentAndShopUuid,
                      agentUuid: user.userId!,
                      isDelete: false,
                      shopId: shop.shopId.toInt(),
                    );
                  },
                  message:
                      'You are about to Assign this Agent to manage this Business. All Comments Created Will be deleted. Are you sure you want to proceed?',
                );
              },
            );
          },
          mouseCursor: SystemMouseCursors.click,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 15,
            ),

            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  children: [
                    Icon(
                      size: 18,
                      color:
                          theme.lightModeColor.tertColor200,
                      Icons.person_add_alt,
                    ),
                    Text(
                      style: TextStyle(
                        fontSize:
                            theme.mobileTexts.b3.fontSize,
                        fontWeight: FontWeight.bold,
                      ),
                      "${user.name} ${user.lastName ?? ''}",
                    ),
                  ],
                ),
                Icon(
                  size: 18,
                  color: Colors.grey,
                  Icons.arrow_forward_ios_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
