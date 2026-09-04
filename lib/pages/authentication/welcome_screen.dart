import 'package:flutter/material.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/buttons/tertiary_button.dart';
import 'package:stockallagent/components/main_container.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/auth_landing.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Scaffold(
      body: Center(
        child: MainContainer(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // spacing: 10,
              children: [
                Image.asset(welcomeIcon, height: 250),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 280,
                  ),
                  child: Column(
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.h2.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        'Welcome to',
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                        'Stockall Agents Portal',
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 100,
                        height: 2,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10),
                          color: theme
                              .lightModeColor
                              .secColor200,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.b2.fontSize,
                          fontWeight: FontWeight.normal,
                        ),
                        'Proceed to Login or Create account to Access your Agent Dashboard',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                  ),
                  child: Column(
                    children: [
                      PrimaryButton(
                        title: 'Create Account',
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AuthLanding(
                                  isLogin: false,
                                );
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      TertiaryButton(
                        title: 'Login',
                        action: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return AuthLanding(
                                  isLogin: true,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
