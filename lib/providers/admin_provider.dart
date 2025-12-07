import 'package:flutter/material.dart';
import 'package:stockallagent/classes/admin_class.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'admins';

  AdminClass? admin;

  Future<AdminClass?> getAdmin() async {
    try {
      Map<String, dynamic>? res = await _client
          .from(tableName)
          .select()
          .eq('user_id', AuthService().currentUser!.id)
          .maybeSingle();
      if (res == null) {
        print('User is not Admin');
        return null;
      }

      var tempAdmin = AdminClass.fromJson(res);

      print(
        "✅ Admin gotten Successfully: ${tempAdmin.name ?? tempAdmin.userId} ",
      );
      admin = tempAdmin;
      return admin;
    } catch (e) {
      print("❌ Error Getting Admin: ${e.toString()}");
      return null;
    }
  }
}
