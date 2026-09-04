import 'package:flutter/material.dart';
import 'package:stockallagent/components/buttons/secondary_button.dart';
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  Text('Stream Error Occured.'),
                  SecondaryButton(
                    title: 'Logout',
                    action: () async {
                      await AuthService().signOut(context);
                      if (context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return WelcomeScreen();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
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
