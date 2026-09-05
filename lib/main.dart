import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/pages/authentication/base_page.dart';
import 'package:stockallagent/pages/4/delete_account.dart';
import 'package:stockallagent/providers/admin_provider.dart';
import 'package:stockallagent/providers/bank_provider.dart';
import 'package:stockallagent/providers/analysis_report_provider.dart';
import 'package:stockallagent/providers/shop_info_provider.dart';
import 'package:stockallagent/providers/resource_provider.dart';
import 'package:stockallagent/providers/user_provider.dart';
import 'package:stockallagent/theme/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, // or any color
      statusBarIconBrightness:
          Brightness.dark, // for Android
      systemNavigationBarContrastEnforced: true,
      statusBarBrightness: Brightness.light,
    ),
  );
  // Lock to portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Supabase.initialize(
    url: 'https://jlwizkdhjazpbllpvtgo.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impsd2l6a2RoamF6cGJsbHB2dGdvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQ5ODU2NzEsImV4cCI6MjA2MDU2MTY3MX0.M3ajvwom-Jj6SfTgATbjwYKtQ1_L4XXo0wcsFcok108',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ResourceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ShopInfoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

ReportProvider returnReportProvider({
  BuildContext? context,
}) {
  if (context != null) {
    return Provider.of<ReportProvider>(context);
  } else {
    return ReportProvider();
  }
}

ThemeProvider returnTheme({BuildContext? context}) {
  if (context == null) {
    return ThemeProvider();
  }
  return Provider.of<ThemeProvider>(context);
}

ResourceProvider returnResourceProvider({
  BuildContext? context,
}) {
  if (context == null) {
    return ResourceProvider();
  }
  return Provider.of<ResourceProvider>(context);
}

UserProvider returnUserProvider({BuildContext? context}) {
  if (context == null) {
    return UserProvider();
  }
  return Provider.of<UserProvider>(context);
}

ShopInfoProvider returnShopProvider({
  BuildContext? context,
}) {
  if (context == null) {
    return ShopInfoProvider();
  }
  return Provider.of<ShopInfoProvider>(context);
}

BankProvider returnBankProvider({BuildContext? context}) {
  if (context == null) {
    return BankProvider();
  } else {
    return Provider.of<BankProvider>(context);
  }
}

AdminProvider returnAdminProvider({BuildContext? context}) {
  if (context == null) {
    return AdminProvider();
  } else {
    return Provider.of<AdminProvider>(context);
  }
}

int? admin(BuildContext context) {
  return returnAdminProvider(context: context).admin?.level;
}

bool topAdmin() {
  return returnAdminProvider().admin?.level == 1 ||
      returnAdminProvider().admin?.level == 2;
}

UserClass currentUser() {
  return returnUserProvider().currentUser!;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stockall Agents Portal',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(
          255,
          248,
          248,
          248,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor:
              returnTheme().lightModeColor.prColor300,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => BasePage(),
        '/delete-account': (context) => DeleteAccount(),
      },
    );
  }
}
