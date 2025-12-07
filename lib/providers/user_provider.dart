import 'package:flutter/material.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  String tableName = 'users';
  UserClass? currentUser;

  List<UserClass> users = [];

  Future<List<UserClass>> getAllUsers() async {
    try {
      var res = await _client.from(tableName).select();
      if (res.isEmpty) {
        print('User Not Found');
        return [];
      }
      var tempUsers = res
          .map((re) => UserClass.fromJson(re))
          .toList();
      print('✅All Users Gotten: ${tempUsers.length}');
      users = tempUsers
          .where(
            (use) =>
                use.userId != AuthService().currentUser!.id,
          )
          .toList();
      notifyListeners();
      return tempUsers;
    } catch (e) {
      print(
        '❌An Error Occured While Getting All Users: ${e.toString()}',
      );
      return [];
    }
  }

  Future<UserClass?> getUser() async {
    try {
      var res = await _client
          .from(tableName)
          .select()
          .eq('user_id', AuthService().currentUser!.id)
          .maybeSingle();
      if (res == null) {
        print('User Not Found');
        return null;
      }
      var tempUser = UserClass.fromJson(res);
      print('✅User Gotten: ${tempUser.name}');
      currentUser = tempUser;
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
          .eq('user_id', currentUser!.userId!)
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
          .eq('user_id', currentUser!.userId!);
      print('User Deleted');
    } catch (e) {
      print('❌ Error Deleting User: ${e.toString()}');
    }
  }
}
