import 'package:flutter/material.dart';
import 'package:stockallagent/classes/subscription_class.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;

  final String tableName = 'subscription';

  List<SubscriptionClass> subscriptions = [];

  Future<List<SubscriptionClass>> getAllSubscriptions({
    required BuildContext context,
  }) async {
    try {
      List<Map<String, dynamic>> response = await _client
          .from(tableName)
          .select();

      var tempSubscriptions = response
          .map((res) => SubscriptionClass.fromJson(res))
          .toList();

      print(
        "✅ All Subscriptions Gotten: ${tempSubscriptions.length}",
      );
      subscriptions = tempSubscriptions;
      notifyListeners();
      return subscriptions;
    } catch (e) {
      print(
        "❌ Error Getting All Subscriptions: ${e.toString()}",
      );
      return [];
    }
  }

  Future<List<SubscriptionClass>> getSubscription({
    required BuildContext context,
  }) async {
    List<int> shopIds = returnShopProvider(
      context: context,
      listen: false,
    ).shops.map((shop) => shop.shopId!).toList();
    try {
      List<Map<String, dynamic>> response = await _client
          .rpc(
            'get_subscription_for_shops',
            params: {'shop_ids': shopIds},
          );

      var tempSubscriptions = response
          .map((res) => SubscriptionClass.fromJson(res))
          .toList();

      print(
        "✅ Subscriptions Gotten: ${tempSubscriptions.length}",
      );
      subscriptions = tempSubscriptions;
      notifyListeners();
      return subscriptions;
    } catch (e) {
      print(
        "❌ Error Getting Subscriptions: ${e.toString()}",
      );
      return [];
    }
  }

  int getSubscriptionPlan(String userId) {
    return subscriptions
        .firstWhere((pay) => pay.userId == userId)
        .plan;
  }

  String getSubscriptionPlanName(String userId) {
    var plan = getSubscriptionPlan(userId);
    if (plan == 0) {
      return "Free";
    } else if (plan == 1) {
      return "Basic";
    } else if (plan == 2) {
      return "Standard";
    } else {
      return "Premium";
    }
  }

  double getShopSubscriptionAmount(String userId) {
    return subscriptions
            .firstWhere((sub) => sub.userId == userId)
            .amount ??
        0;
  }

  double totalMoney() {
    double temp = 0;
    for (var pay in subscriptions) {
      if (pay.lastPayment != null &&
          pay.lastPayment!.isAfter(
            monthStart().subtract(
              Duration(microseconds: 1),
            ),
          ) &&
          pay.plan != 0) {
        temp += pay.amount ?? 0;
      }
    }
    return temp;
  }

  double getCut() {
    return totalMoney() * referralCut;
  }
}
