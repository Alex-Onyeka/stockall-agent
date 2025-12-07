import 'package:flutter/material.dart';
import 'package:stockallagent/classes/shop_class.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/dashboard/dashboard.dart';
import 'package:stockallagent/pages/payments/payments.dart';
import 'package:stockallagent/pages/profile/profile.dart';
import 'package:stockallagent/pages/stores/stores.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;

  void navActionMain(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void profileNavAction() {
    setState(() {
      currentPage = 3;
    });
  }

  void popPageAction() {
    setState(() {
      currentPage = 0;
    });
  }

  late Future<List<ShopClass>> getShopsFuture;
  Future<List<ShopClass>> getShop() async {
    return await returnShopProvider(
      context: context,
      listen: false,
    ).getShops(context);
  }

  // late Future<UserClass?> getUserFuture;
  // Future<UserClass?> getUser() async {
  //   return await returnUserProvider(
  //     context: context,
  //     listen: false,
  //   ).getUser();
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnResourceProvider(
        context: context,
        listen: false,
      ).toggleLoading(false);
    });
    getShopsFuture = getShop();
  }

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: FutureBuilder(
        future: getShopsFuture,
        builder: (context, shopSnapshot) {
          if (shopSnapshot.connectionState ==
              ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          } else if (shopSnapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('An Error Occured Shops'),
              ),
            );
          } else {
            return Scaffold(
              body: Builder(
                builder: (context) {
                  if (currentPage == 0) {
                    return Dashboard(
                      profileNavAction: () {
                        profileNavAction();
                      },
                      navigate: () {
                        navActionMain(1);
                      },
                    );
                  } else if (currentPage == 1) {
                    return Stores(
                      popPage: () {
                        popPageAction();
                      },
                      profileNavAction: () {
                        profileNavAction();
                      },
                    );
                  } else if (currentPage == 2) {
                    return Payments(
                      popPage: () {
                        popPageAction();
                      },
                    );
                  } else {
                    return Profile(
                      popPage: () {
                        popPageAction();
                      },
                    );
                  }
                },
              ),
              bottomNavigationBar: SizedBox(
                width: double.infinity,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    25.0,
                    10,
                    25,
                    10,
                  ),
                  child: Row(
                    spacing: 5,
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      NavButtons(
                        theme: theme,
                        icon: Icons.home_rounded,
                        mainIndex: currentPage,
                        myIndex: 0,
                        title: 'Home',
                        navAction: () {
                          navActionMain(0);
                        },
                      ),
                      NavButtons(
                        theme: theme,
                        icon: Icons.home_work_rounded,
                        mainIndex: currentPage,
                        myIndex: 1,
                        title: 'Stores',
                        navAction: () {
                          navActionMain(1);
                        },
                      ),
                      NavButtons(
                        theme: theme,
                        icon: Icons.receipt_rounded,
                        mainIndex: currentPage,
                        myIndex: 2,
                        title: 'Payments',
                        navAction: () {
                          navActionMain(2);
                        },
                      ),
                      NavButtons(
                        theme: theme,
                        icon: Icons.person,
                        mainIndex: currentPage,
                        myIndex: 3,
                        title: 'Profile',
                        navAction: () {
                          navActionMain(3);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class NavButtons extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? navAction;
  final int myIndex;
  final int mainIndex;
  final ThemeProvider theme;

  const NavButtons({
    super.key,
    required this.title,
    required this.icon,
    this.navAction,
    required this.myIndex,
    required this.mainIndex,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: navAction,
          child: SizedBox(
            child: Column(
              spacing: 0,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 22,
                  color: mainIndex == myIndex
                      ? theme.lightModeColor.prColor300
                      : Colors.grey,
                  icon,
                ),
                Text(
                  style: TextStyle(
                    fontSize: mainIndex == myIndex
                        ? theme.mobileTexts.b3.fontSize
                        : theme.mobileTexts.b4.fontSize,
                    fontWeight: mainIndex == myIndex
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
