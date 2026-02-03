import 'package:flutter/material.dart';
import 'package:stockallagent/classes/sub_payments.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubPaymentsProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'subscription_payments';

  List<SubPaymentClass> subPayments = [];

  void clearSubPayments() {
    subPayments.clear();
    print('Sub Payments Cleared');
    notifyListeners();
  }

  Future<List<SubPaymentClass>> getSubPayments() async {
    try {
      List<Map<String, dynamic>> res = await _client.rpc(
        'get_this_month_subscription_payments',
      );

      if (res.isEmpty) {
        print(
          'No Subscription Payment gotten For this Month',
        );
        subPayments = [];
        notifyListeners();
        return [];
      }

      var tempPayments = res
          .map((re) => SubPaymentClass.fromJson(re))
          .toList();

      print(
        "✅ SubScription Payments Gotten: ${tempPayments.length} ${tempPayments.first.userId}",
      );
      subPayments = tempPayments;
      notifyListeners();
      return subPayments;
    } catch (e) {
      print(
        "❌ Error Getting Subscription Payments: ${e.toString()}",
      );
      subPayments = [];
      notifyListeners();
      return [];
    }
  }

  double getTotalSubAmountAdmin() {
    double tempTotal = 0;
    for (var sub in subPayments) {
      tempTotal += sub.amount ?? 0;
    }
    return tempTotal;
  }

  double getNetRevenueAdmin(BuildContext context) {
    double amount =
        returnRefPaymentsProvider(
              context: context,
              listen: false,
            ).payments
            .where(
              (pay) =>
                  pay.createdDate!.isAfter(monthStart()) ||
                  pay.createdDate!.isAtSameMomentAs(
                    monthEnd(),
                  ),
            )
            .map((pay) => pay.amount ?? 0)
            .toList()
            .fold(0, (s, v) => s + v);

    return getTotalSubAmountAdmin() - amount;
  }

  double getTotalAgentsCutAdmin(BuildContext context) {
    double amount =
        returnRefPaymentsProvider(
              context: context,
              listen: false,
            ).payments
            .where(
              (pay) =>
                  pay.createdDate!.isAfter(monthStart()) ||
                  pay.createdDate!.isAtSameMomentAs(
                    monthEnd(),
                  ),
            )
            .map((pay) => pay.amount ?? 0)
            .toList()
            .fold(0, (s, v) => s + v);

    return amount;
  }

  List<SubPaymentClass> getAgentsSubPaymentsList(
    BuildContext context,
    String refCode,
  ) {
    var shops =
        returnShopProvider(context: context, listen: false)
            .shops
            .where((sh) => sh.refCode == refCode)
            .toList()
            .map((shop) => shop.userId)
            .toList();
    List<SubPaymentClass> temp = [];
    for (var sub in subPayments) {
      if (shops.contains(sub.userId)) {
        temp.add(sub);
      }
    }
    return temp;
  }

  double getAgentsCutForMonthsPayment(
    String refCode,
    String role,
    BuildContext context,
  ) {
    double temp = 0;
    for (var sub in getAgentsSubPaymentsList(
      context,
      refCode,
    )) {
      temp += sub.amount ?? 0;
    }
    return temp * (referralCut(role));
  }

  double getAgentsTotalForMonth(
    String refCode,
    BuildContext context,
  ) {
    double temp = 0;
    for (var sub in getAgentsSubPaymentsList(
      context,
      refCode,
    )) {
      temp += sub.amount ?? 0;
    }
    return temp;
  }
}
