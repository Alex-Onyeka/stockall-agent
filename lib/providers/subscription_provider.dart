// import 'package:flutter/material.dart';
// import 'package:stockallagent/classes/subscription_class.dart';
// import 'package:stockallagent/constants/constants_main.dart';
// import 'package:stockallagent/main.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SubscriptionProvider extends ChangeNotifier {
//   static final SubscriptionProvider _instance =
//       SubscriptionProvider._internal();
//   factory SubscriptionProvider() => _instance;
//   SubscriptionProvider._internal();
//   final SupabaseClient _client = Supabase.instance.client;

//   final String tableName = 'subscription';

//   List<SubscriptionClass> subscriptions = [];

//   void clearSubscriptions() {
//     subscriptions.clear();
//     print('Subscriptions Cleared');
//     notifyListeners();
//   }

//   Future<List<SubscriptionClass>> getAllSubscriptions({
//     required BuildContext context,
//   }) async {
//     try {
//       List<Map<String, dynamic>> response = await _client
//           .from(tableName)
//           .select();

//       if (response.isEmpty) {
//         print('No Subscription gotten');
//         subscriptions = [];
//         notifyListeners();
//         return [];
//       }

//       var tempSubscriptions = response
//           .map((res) => SubscriptionClass.fromJson(res))
//           .toList();

//       print(
//         "✅ All Subscriptions Gotten: ${tempSubscriptions.length}",
//       );
//       subscriptions = tempSubscriptions;
//       notifyListeners();
//       return subscriptions;
//     } catch (e) {
//       print(
//         "❌ Error Getting All Subscriptions: ${e.toString()}",
//       );
//       subscriptions = [];
//       notifyListeners();
//       return [];
//     }
//   }

//   Future<List<SubscriptionClass>> getSubscription({
//     required BuildContext context,
//   }) async {
//     List<int> shopIds = returnShopProvider(
//       context: context,
//       listen: false,
//     ).shops.map((shop) => shop.shopId!).toList();
//     try {
//       List<Map<String, dynamic>> response = await _client
//           .rpc(
//             'get_subscription_for_shops',
//             params: {'shop_ids': shopIds},
//           );

//       if (response.isEmpty) {
//         print('No Subscription gotten');
//         subscriptions = [];
//         notifyListeners();
//         return [];
//       }

//       var tempSubscriptions = response
//           .map((res) => SubscriptionClass.fromJson(res))
//           .toList();

//       print(
//         "✅ Subscriptions Gotten: ${tempSubscriptions.length}",
//       );
//       subscriptions = tempSubscriptions;
//       notifyListeners();
//       return subscriptions;
//     } catch (e) {
//       print(
//         "❌ Error Getting Subscriptions: ${e.toString()}",
//       );
//       subscriptions = [];
//       notifyListeners();
//       return [];
//     }
//   }

//   SubscriptionClass getShopSubscription(String userId) {
//     return subscriptions.firstWhere(
//       (sub) => sub.userId == userId,
//     );
//   }

//   int getShopSubscriptionPlan(String userId) {
//     return subscriptions
//         .firstWhere((sub) => sub.userId == userId)
//         .plan;
//   }

//   String getShopSubscriptionPlanName(String userId) {
//     var plan = getShopSubscriptionPlan(userId);
//     if (plan == 0) {
//       return "Free";
//     } else if (plan == 1) {
//       return "Basic";
//     } else if (plan == 2) {
//       return "Standard";
//     } else if (plan == 3) {
//       return "Premium";
//     } else if (plan == 4) {
//       return "Silver";
//     } else {
//       return "Gold";
//     }
//   }

//   double getFirst6MonthsAmount({
//     required SubscriptionClass? sub,
//   }) {
//     if (sub?.amount == null || sub?.nextPayment == null) {
//       return 0;
//     }

//     if (getMonthDifference(
//           sub!.lastPayment!,
//           sub.nextPayment!,
//         ) <=
//         6) {
//       return sub.amount!;
//     }

//     return (sub.amount! /
//             getMonthDifference(
//               sub.lastPayment!,
//               sub.nextPayment!,
//             )) *
//         6;
//   }

//   // double getShopSubscriptionAmount(String userId) {
//   //   return subscriptions
//   //           .firstWhere((sub) => sub.userId == userId)
//   //           .amount ??
//   //       0;
//   // }

//   // double getShopSubscription(String userId) {
//   //   return subscriptions
//   //           .firstWhere((sub) => sub.userId == userId)
//   //           .amount ??
//   //       0;
//   // }

//   double totalMoney() {
//     double temp = 0;
//     for (var pay in subscriptions) {
//       if (pay.lastPayment != null &&
//           pay.lastPayment!.isAfter(
//             monthStart().subtract(
//               Duration(microseconds: 1),
//             ),
//           ) &&
//           pay.plan != 0) {
//         temp += pay.amount ?? 0;
//       }
//     }
//     return temp;
//   }

//   double getCut(
//     BuildContext context,
//     String agentId,
//     String role,
//   ) {
//     return (totalMoney() * referralCut(role)) -
//         returnRefPaymentsProvider(
//           context: context,
//         ).getAgentTotalPayment(agentId);
//   }
// }
