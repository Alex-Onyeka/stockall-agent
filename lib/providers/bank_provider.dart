import 'package:flutter/material.dart';
import 'package:stockallagent/classes/bank_class.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'bank_details';

  BankClass? bank;

  List<BankClass> banks = [];

  Future<List<BankClass>> getAllBanks() async {
    try {
      List<Map<String, dynamic>> res = await _client
          .from(tableName)
          .select();

      if (res.isEmpty) {
        print("No Bank Found");
        return [];
      }

      var tempBank = res
          .map((re) => BankClass.fromJson(re))
          .toList();
      print(
        '✅ All Banks Gotten Success: ${tempBank.length}',
      );
      banks = tempBank;
      notifyListeners();
      return tempBank;
    } catch (e) {
      print("❌ Error Getting All Bankk: ${e.toString()}");
      return [];
    }
  }

  Future<BankClass?> getBank() async {
    try {
      Map<String, dynamic>? res = await _client
          .from(tableName)
          .select()
          .eq('user_id', AuthService().currentUser!.id)
          .maybeSingle();

      if (res == null) {
        print("No Bank Found");
        bank = null;
        notifyListeners();
        return null;
      }

      var tempBank = BankClass.fromJson(res);
      print(
        '✅Bank Gotten Success: ${tempBank.accountName}',
      );
      bank = tempBank;
      notifyListeners();
      return tempBank;
    } catch (e) {
      print("❌ Error Getting Bankk: ${e.toString()}");
      return null;
    }
  }

  Future<int> createBank(BankClass newBank) async {
    try {
      Map<String, dynamic>? res = await _client
          .from(tableName)
          .insert(newBank.toJson())
          .select()
          .maybeSingle();
      if (res == null) {
        print("❌ Insertion Failed");
        return 0;
      }
      var tempBank = BankClass.fromJson(res);
      print(
        '✅Bank Created Success: ${tempBank.accountName}',
      );
      bank = tempBank;
      notifyListeners();
      return 1;
    } catch (e) {
      print("❌ Error Inserting Bank: ${e.toString()}");
      return 0;
    }
  }

  Future<int> updateBank(BankClass newBank) async {
    try {
      Map<String, dynamic>? res = await _client
          .from(tableName)
          .update(newBank.toJson())
          .eq("id", newBank.bankId!)
          .select()
          .maybeSingle();
      if (res == null) {
        print("❌ Insertion Failed");
        return 0;
      }
      var tempBank = BankClass.fromJson(res);
      print(
        '✅Bank Updated Success: ${tempBank.accountName}',
      );
      bank = tempBank;
      notifyListeners();
      return 1;
    } catch (e) {
      print("❌ Error Inserting Bank: ${e.toString()}");
      return 0;
    }
  }
}
