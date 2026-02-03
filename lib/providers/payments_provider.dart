import 'package:flutter/material.dart';
import 'package:stockallagent/classes/ref_payments_class.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RefPaymentsProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'ref_payments';

  List<RefPaymentsClass> payments = [];

  void clearPayments() {
    payments.clear();
    print('Ref Payments Cleared');
    notifyListeners();
  }

  Future<List<RefPaymentsClass>> getAllPayments() async {
    try {
      List<Map<String, dynamic>> res = await _client
          .from(tableName)
          .select();

      if (res.isEmpty) {
        print("No Payment Gotten");
        payments = [];
        notifyListeners();
        return [];
      }
      print("✅ All Payments Gotten Success: ${res.length}");

      List<RefPaymentsClass> tempPayments = res
          .map((pay) => RefPaymentsClass.fromJson(pay))
          .toList();

      payments = tempPayments;
      payments.sort(
        (a, b) => a.createdDate!.compareTo(b.createdDate!),
      );
      notifyListeners();
      return payments;
    } catch (e) {
      payments = [];
      notifyListeners();
      print(
        "❌ Error Getting All Payments: ${e.toString()}",
      );
      return [];
    }
  }

  Future<List<RefPaymentsClass>> getPayments() async {
    try {
      List<Map<String, dynamic>> res = await _client
          .from(tableName)
          .select()
          .eq('user_id', AuthService().currentUser!.id);

      if (res.isEmpty) {
        payments = [];
        notifyListeners();
        print("No Payment Gotten");
        return [];
      }
      print("✅ Payments Gotten Success: ${res.length}");

      List<RefPaymentsClass> tempPayments = res
          .map((pay) => RefPaymentsClass.fromJson(pay))
          .toList();

      payments = tempPayments;
      payments.sort(
        (a, b) => a.createdDate!.compareTo(b.createdDate!),
      );
      notifyListeners();
      return payments;
    } catch (e) {
      payments = [];
      notifyListeners();
      print("❌ Error Getting Payments: ${e.toString()}");
      return [];
    }
  }

  Future<int> makePayment(RefPaymentsClass payment) async {
    try {
      var res = await _client
          .from(tableName)
          .insert(payment.toJson())
          .select()
          .maybeSingle();
      if (res == null) {
        print("Payment Failed");
        return 0;
      }
      notifyListeners();
      print('✅ Payment Success');
      await getAllPayments();
      return 1;
    } catch (e) {
      print('❌Payment Failed: ${e.toString()}');
      return 0;
    }
  }

  double getAgentTotalPayment(String agentId) {
    return payments
        .where((pay) => pay.userId == agentId)
        .map((p) => (p.amount ?? 0))
        .toList()
        .fold(
          0,
          (previousValue, element) =>
              previousValue + element,
        );
  }

  double getTotalPayments() {
    double temp = 0;
    for (var pay in payments) {
      temp += pay.amount ?? 0;
    }
    return temp;
  }

  List<RefPaymentsClass> getThisMonthPayments() {
    var tempPays = payments
        .where(
          (pay) =>
              (pay.createdDate!.isAfter(monthStart()) ||
              pay.createdDate!.isAtSameMomentAs(
                monthStart(),
              )),
        )
        .toList();

    tempPays.sort(
      (a, b) => b.createdDate!.compareTo(a.createdDate!),
    );
    return tempPays;
  }
}
