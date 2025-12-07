import 'package:flutter/material.dart';
import 'package:stockallagent/classes/admin_class.dart';
import 'package:stockallagent/classes/shop_class.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ShopProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'shops';

  List<ShopClass> shops = [];

  Future<List<ShopClass>> getShops(
    BuildContext context,
  ) async {
    UserClass? user = await returnUserProvider(
      context: context,
      listen: false,
    ).getUser();
    if (user == null) {
      print('User not Found');
      return [];
    } else {
      if (!context.mounted) {
        print("Context is Not mounted");
        return [];
      }
      AdminClass? admin = await returnAdminProvider(
        context: context,
        listen: false,
      ).getAdmin();
      print("Admin Name: ${admin?.name}");

      if (admin == null) {
        print('📍📍User is Not an Admin');
        try {
          var res = await _client
              .from(tableName)
              .select()
              .eq('ref_code', user.referralCode!);

          if (res.isEmpty) {
            print('No Shops Gotten');
            return [];
          }

          shops = res
              .map((shop) => ShopClass.fromJson(shop))
              .toList();

          print("✅ Shops Gotten Success: ${shops.length}");
          if (context.mounted) {
            await returnSubscriptionProvider(
              context: context,
              listen: false,
            ).getSubscription(context: context);
            if (context.mounted) {
              await returnBankProvider(
                context: context,
                listen: false,
              ).getBank();
            }
            if (context.mounted) {
              await returnRefPaymentsProvider(
                context: context,
                listen: false,
              ).getPayments();
            }
          }
          shops.sort((a, b) => a.name.compareTo(b.name));
          notifyListeners();
          return shops;
        } catch (e) {
          print('❌ Error Getting Shops: ${e.toString()}');
          // notifyListeners();
          return [];
        }
      } else {
        print('❤❤User is an Admin');
        try {
          List<Map<String, dynamic>> res = await _client
              .from(tableName)
              .select();

          shops = res
              .map((sh) => ShopClass.fromJson(sh))
              .toList();

          if (shops.isEmpty) {
            print("No Shops Found");
            return [];
          }

          if (context.mounted) {
            await returnUserProvider(
              context: context,
              listen: false,
            ).getAllUsers();
            if (context.mounted) {
              returnSubscriptionProvider(
                context: context,
                listen: false,
              ).getAllSubscriptions(context: context);
            }
            if (context.mounted) {
              await returnBankProvider(
                context: context,
                listen: false,
              ).getAllBanks();
            }
            if (context.mounted) {
              await returnRefPaymentsProvider(
                context: context,
                listen: false,
              ).getAllPayments();
            }
          }
          print(
            "✅ All Shops Gotten Success: ${shops.length}",
          );
          return shops;
        } catch (e) {
          print(
            "❌ Error Getting all Shops: ${e.toString()}",
          );
          return [];
        }
      }
    }
  }

  List<ShopClass> getThisMonthSubscribedShops(
    BuildContext context,
  ) {
    var payments =
        returnSubscriptionProvider(
              context: context,
              listen: false,
            ).subscriptions
            .where(
              (pay) =>
                  pay.lastPayment != null &&
                  !pay.lastPayment!.isBefore(
                    monthStart().subtract(
                      Duration(microseconds: 1),
                    ),
                  ) &&
                  pay.plan != 0,
            )
            .toList();

    payments.sort(
      (a, b) => b.lastPayment!.compareTo(a.lastPayment!),
    );

    final Map<String, ShopClass> shopByUserId = {
      for (var sh in shops) sh.userId: sh,
    };

    List<ShopClass> sortedShops = [];
    for (var pay in payments) {
      final shop = shopByUserId[pay.userId];
      if (shop != null && !sortedShops.contains(shop)) {
        sortedShops.add(shop);
      }
    }

    return sortedShops;
  }

  List<ShopClass> getTotalSubscribedShops(
    BuildContext context,
  ) {
    var payments = returnSubscriptionProvider(
      context: context,
      listen: false,
    ).subscriptions.where((pay) => pay.plan != 0).toList();

    payments.sort(
      (a, b) => b.lastPayment!.compareTo(a.lastPayment!),
    );

    final Map<String, ShopClass> shopByUserId = {
      for (var sh in shops) sh.userId: sh,
    };

    List<ShopClass> sortedShops = [];
    for (var pay in payments) {
      final shop = shopByUserId[pay.userId];
      if (shop != null && !sortedShops.contains(shop)) {
        sortedShops.add(shop);
      }
    }

    return sortedShops;
  }

  List<ShopClass> getTotalUnsubscribedShops(
    BuildContext context,
  ) {
    var payments = returnSubscriptionProvider(
      context: context,
      listen: false,
    ).subscriptions.where((pay) => pay.plan == 0).toList();

    payments.sort(
      (a, b) => b.lastPayment!.compareTo(a.lastPayment!),
    );

    final Map<String, ShopClass> shopByUserId = {
      for (var sh in shops) sh.userId: sh,
    };

    List<ShopClass> sortedShops = [];
    for (var pay in payments) {
      final shop = shopByUserId[pay.userId];
      if (shop != null && !sortedShops.contains(shop)) {
        sortedShops.add(shop);
      }
    }

    return sortedShops;
  }
}
