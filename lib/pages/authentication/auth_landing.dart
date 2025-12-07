import 'package:flutter/material.dart';
import 'package:stockallagent/pages/authentication/login_page.dart';
import 'package:stockallagent/pages/authentication/sign_up_page.dart';

class AuthLanding extends StatefulWidget {
  final bool isLogin;
  const AuthLanding({super.key, required this.isLogin});

  @override
  State<AuthLanding> createState() => _AuthLandingState();
}

class _AuthLandingState extends State<AuthLanding> {
  bool isLogin = true;
  void togglePages(bool value) {
    setState(() {
      isLogin = value;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLogin = widget.isLogin;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LoginPage(
        goToSignUp: () {
          togglePages(false);
        },
      );
    } else {
      return SignUpPage(
        goToLogin: () {
          togglePages(true);
        },
      );
    }
  }
}
