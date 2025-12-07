import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stockallagent/pages/authentication/base_page.dart';
import 'package:stockallagent/providers/admin_provider.dart';
import 'package:stockallagent/providers/bank_provider.dart';
import 'package:stockallagent/providers/payments_provider.dart';
import 'package:stockallagent/providers/subscription_provider.dart';
import 'package:stockallagent/providers/resource_provider.dart';
import 'package:stockallagent/providers/shop_provider.dart';
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
          create: (context) => ShopProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubscriptionProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BankProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RefPaymentsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),
        ),
      ],
      builder: (context, child) => const MyApp(),
    ),
  );
}

ThemeProvider returnTheme({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<ThemeProvider>(
    context,
    listen: listen,
  );
}

ResourceProvider returnResourceProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<ResourceProvider>(
    context,
    listen: listen,
  );
}

UserProvider returnUserProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<UserProvider>(context, listen: listen);
}

ShopProvider returnShopProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<ShopProvider>(context, listen: listen);
}

SubscriptionProvider returnSubscriptionProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<SubscriptionProvider>(
    context,
    listen: listen,
  );
}

BankProvider returnBankProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<BankProvider>(context, listen: listen);
}

RefPaymentsProvider returnRefPaymentsProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<RefPaymentsProvider>(
    context,
    listen: listen,
  );
}

AdminProvider returnAdminProvider({
  required BuildContext context,
  bool listen = true,
}) {
  return Provider.of<AdminProvider>(
    context,
    listen: listen,
  );
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
          seedColor: returnTheme(
            context: context,
            listen: false,
          ).lightModeColor.prColor300,
        ),
      ),
      home: BasePage(),
    );
  }
}
