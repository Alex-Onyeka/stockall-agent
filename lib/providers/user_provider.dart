import 'package:flutter/material.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/providers/bank_provider.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  static final UserProvider _instance =
      UserProvider._internal();
  factory UserProvider() => _instance;
  UserProvider._internal();
  final SupabaseClient _client = Supabase.instance.client;
  String tableName = 'agents';
  UserClass? currentUser;

  List<UserClass> agents = [];

  Future<int> createAgent(UserClass user) async {
    // user.role = selectedRole;
    try {
      var res = await _client
          .from(tableName)
          .insert(user.toJson())
          .select()
          .maybeSingle();

      if (res == null) {
        print('User Creation Failed');
        return 0;
      }

      var tempUser = UserClass.fromJson(res);
      print('✅ User Created Successfully');
      notifyListeners();
      currentUser = tempUser;
      return 1;
    } catch (e) {
      print("❌ Error Creating User: ${e.toString()}");
      return 0;
    }
  }

  Future<List<UserClass>> getAgents() async {
    try {
      List<Map<String, dynamic>> res = await _client.rpc(
        'get_agents',
      );

      if (res.isEmpty) {
        print('Users Not Found');
        agents = [];
        notifyListeners();
        return [];
      }
      print(res.length);
      List<UserClass> tempUsers = res
          .map((re) => UserClass.fromJson(re))
          .toList();
      print('✅All Users Gotten: ${tempUsers.length}');
      agents = tempUsers
          .where(
            (use) =>
                use.userId != AuthService().currentUser!.id,
          )
          .toList();
      agents.sort(
        ((a, b) => a.name.toLowerCase().compareTo(
          b.name.toLowerCase(),
        )),
      );
      notifyListeners();
      return tempUsers;
    } catch (e) {
      print(
        '❌An Error Occured While Getting All Users: ${e.toString()}',
      );
      agents = [];
      notifyListeners();
      return [];
    }
  }

  Future<UserClass?> getUser() async {
    try {
      var res = await _client
          .from(tableName)
          .select()
          .eq('uuid', AuthService().currentUser!.id)
          .maybeSingle();
      if (res == null) {
        print('User Not Found');
        return null;
      }
      var tempUser = UserClass.fromJson(res);
      print('✅User Gotten: ${tempUser.name}');
      currentUser = tempUser;
      await BankProvider().getBank();
      notifyListeners();
      return tempUser;
    } catch (e) {
      print(
        '❌An Error Occured While Getting User: ${e.toString()}',
      );
      return null;
    }
  }

  Future<int> updateUser(UserClass user) async {
    try {
      var res = await _client
          .from(tableName)
          .update(user.toJson())
          .eq('uuid', currentUser!.userId!)
          .select()
          .maybeSingle();

      if (res == null) {
        print('User Update Failed');
        return 0;
      }

      var tempUser = UserClass.fromJson(res);
      print('✅ User Update Success');
      notifyListeners();
      currentUser = tempUser;
      return 1;
    } catch (e) {
      print("❌ Error Updating User: ${e.toString()}");
      return 0;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _client
          .from(tableName)
          .delete()
          .eq('uuid', currentUser!.userId!);
      print('User Deleted');
    } catch (e) {
      print('❌ Error Deleting User: ${e.toString()}');
    }
  }
}
