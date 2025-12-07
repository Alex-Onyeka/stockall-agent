import 'package:flutter/material.dart';
import 'package:stockallagent/classes/ref_payments_class.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RefPaymentsProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'ref_payments';

  List<RefPaymentsClass> payments = [];

  Future<List<RefPaymentsClass>> getAllPayments() async {
    try {
      List<Map<String, dynamic>> res = await _client
          .from(tableName)
          .select();

      if (res.isEmpty) {
        print("No Payment Gotten");
        return [];
      }
      print("✅ All Payments Gotten Success: ${res.length}");

      List<RefPaymentsClass> tempPayments = res
          .map((pay) => RefPaymentsClass.fromJson(pay))
          .toList();

      payments = tempPayments;
      payments.sort(
        (a, b) => a.createdDate.compareTo(b.createdDate),
      );
      notifyListeners();
      return payments;
    } catch (e) {
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
        print("No Payment Gotten");
        return [];
      }
      print("✅ Payments Gotten Success: ${res.length}");

      List<RefPaymentsClass> tempPayments = res
          .map((pay) => RefPaymentsClass.fromJson(pay))
          .toList();

      payments = tempPayments;
      payments.sort(
        (a, b) => a.createdDate.compareTo(b.createdDate),
      );
      notifyListeners();
      return payments;
    } catch (e) {
      print("❌ Error Getting Payments: ${e.toString()}");
      return [];
    }
  }

  double getTotalPayments() {
    double temp = 0;
    for (var pay in payments) {
      temp += pay.amount ?? 0;
    }
    return temp;
  }
}
