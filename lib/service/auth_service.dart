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

      // Build user row
      final userRow = UserClass(
        userId: userId,
        createdAt: user.createdAt,
        name: user.name,
        lastName: user.lastName,
        email: newEmail ?? user.email,
        phone: user.phone,
        password: user.password,
      );

      await _client.from('users').insert(userRow.toJson());
      print(
        '${newEmail != null ? 'Email Changed Successfully' : 'Email Verified Successfully'}',
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
      returnUserProvider(
        context: context,
        listen: false,
      ).currentUser = null;
      returnShopProvider(
        context: context,
        listen: false,
      ).shops.clear();
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

  // Future<String> changePasswordAndUpdateLocal({
  //   required String newPassword,
  //   required BuildContext context,
  // }) async {
  //   try {
  //     final response = await _client.auth.updateUser(
  //       UserAttributes(password: newPassword),
  //     );

  //     final user = response.user;
  //     if (user == null) {
  //       throw Exception(
  //         "Password update failed: No user returned.",
  //       );
  //     }

  //     print(
  //       "🔐 Password successfully updated in Supabase Auth for ${user.email}",
  //     );

  //     print("Updating user with ID: ${user.id}");

  //     // ✅ Step 2: Update password in your 'users' table
  //     final updateResponse = await _client
  //         .from('users')
  //         .update({'password': newPassword})
  //         .eq('user_id', user.id)
  //         .select()
  //         .maybeSingle();

  //     // 4. Store the user in local DB
  //     print("context.mounted = ${context.mounted}");
  //     if (context.mounted) {
  //       print("✅ Inserting Users into the Local");
  //       await returnUserProvider(
  //         context,
  //         listen: false,
  //       ).getUser(context);
  //       return 'Success';
  //     } else {
  //       print(
  //         "⚠️ Context no longer mounted, skipping local insert",
  //       );
  //     }

  //     print(
  //       "✅ Password updated in 'users' table: $updateResponse",
  //     );
  //     return 'Success';
  //   } on AuthException catch (e) {
  //     print('Error Changing Password: $e');
  //     return e.statusCode!;
  //   } catch (e) {
  //     print(e);
  //     return e.toString();
  //   }
  // }

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

      final response = await _client.functions.invoke(
        'delete-user',
        body: {'userId': user.id},
      );

      if (response.status == 200) {
        print(
          "User deleted successfully: ${response.data}",
        );
        await returnUserProvider(
          context: context,
          listen: false,
        ).deleteUser();
        await signOut(context);
        return 1;
      } else {
        print(
          "Error Deleting User Account: ${response.data}",
        );
        return 0;
      }
    } catch (e) {
      print("Error Deleting User Account: ${e.toString()}");
      return 0;
    }
  }
}
