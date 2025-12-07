import 'package:flutter/material.dart';
import 'package:stockallagent/pages/authentication/welcome_screen.dart';
import 'package:stockallagent/pages/home/home.dart';
import 'package:stockallagent/service/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().authStateChanges,
      builder: (context, stream) {
        if (stream.connectionState ==
            ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (stream.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Stream Error Occured'),
            ),
          );
        } else {
          Session? session = stream.data!.session;
          if (session == null) {
            return WelcomeScreen();
          } else {
            if (session.user.emailConfirmedAt != null) {
              return Home();
            } else {
              return WelcomeScreen();
            }
          }
        }
      },
    );
  }
}
