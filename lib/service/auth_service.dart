import 'package:flutter/material.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  Stream<AuthState> get authStateChanges =>
      _client.auth.onAuthStateChange;

  SupabaseClient get client => _client;

  Future<AuthResponse> signUpAndCreateUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final signUpRes = await _client.auth.signUp(
      email: email,
      password: password,
    );

    final userId = signUpRes.user?.id;

    if (userId == null) {
      throw Exception('Failed to sign up user.');
    }

    return signUpRes;
  }

  Future<void> resendVerificationLink(String email) async {
    try {
      await _client.auth.resend(
        type: OtpType.signup,
        email: email,
      );
      print('Success');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<int> verifyOtp({
    required String otp,
    required UserClass user,
    required String userId,
    String? newEmail,
  }) async {
    try {
      await _client.auth.verifyOTP(
        type: newEmail == null
            ? OtpType.signup
            : OtpType.emailChange,
        email: newEmail ?? user.email,
        token: otp,
      );
      print('Finished Verifying');

      // Build user row
      final userRow = UserClass(
        roleId: 1,
        userId: userId,
        createdAt: user.createdAt,
        name: user.name,
        lastName: user.lastName,
        email: newEmail ?? user.email,
        phone: user.phone,
        password: user.password,
        // role: user.role,
      );
      print(userRow);
      print('Finished Mapping User Class');

      await _client.from('agents').insert(userRow.toJson());
      print(
        newEmail != null
            ? 'Email Changed Successfully'
            : 'Email Verified Successfully',
      );
      return 1;
    } catch (e) {
      print('Error: ${e.toString()}');
      return 0;
    }
  }

  Future<void> sendEmailResetOtp(String emaill) async {
    try {
      await Supabase.instance.client.auth.updateUser(
        UserAttributes(email: emaill),
      );
      print('Email reset OTP sent.');
    } catch (e) {
      print('Error sending OTP to email: $e');
    }
  }

  Future<void> resendEmailChangeVerificationOTP(
    String email,
  ) async {
    try {
      await _client.auth.resend(
        type: OtpType.emailChange,
        email: email,
      );
      print('Email Change OTP Resent Success');
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }

  Future<int> signIn(String email, String password) async {
    try {
      final authResponse = await _client.auth
          .signInWithPassword(
            email: email,
            password: password,
          );

      final user = authResponse.user;
      if (user == null) {
        throw Exception("No user returned from sign-in.");
      }

      print("✅ User signed in");

      return 1;
    } catch (e) {
      print("❌ Sign-in failed: ${e.toString()}");
      return 0;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _client.auth.signOut();
    if (context.mounted) {
      returnUserProvider().currentUser = null;
      returnShopProvider().shopInfos.clear();
    } else {
      print('Context not Mounted');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await Supabase.instance.client.auth
          .resetPasswordForEmail(
            email,
            redirectTo:
                'https://www.stockallapp.com/#/reset-password',
          );
      print('Password reset email sent.');
    } catch (e) {
      print('Error sending reset email: $e');
    }
  }

  User? get currentUser => _client.auth.currentUser;

  Future<int> deleteUserAccount(
    BuildContext context,
  ) async {
    try {
      // 1. Get the current user
      final user = _client.auth.currentUser;

      if (user == null) {
        print("No user is currently signed in.");
        return 0;
      }
      var tempUser = await _client
          .from('users')
          .select()
          .eq('user_id', user.id)
          .maybeSingle();
      if (tempUser != null) {
        await _client
            .from('agents')
            .delete()
            .eq('uuid', user.id);
        await signOut(context);
        return 1;
      } else {
        final response = await _client.functions.invoke(
          'delete-user',
          body: {'userId': user.id},
        );

        if (response.status == 200) {
          print(
            "User deleted successfully: ${response.data}",
          );
          await returnUserProvider().deleteUser();
          await signOut(context);
          return 1;
        } else {
          print(
            "Error Deleting User Account: ${response.data}",
          );
          return 0;
        }
      }
    } catch (e) {
      print("Error Deleting User Account: ${e.toString()}");
      return 0;
    }
  }
}
