import 'package:flutter/material.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/buttons/secondary_button.dart';
import 'package:stockallagent/components/main_container.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/validate_user_exists.dart';
import 'package:stockallagent/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? goToSignUp;
  const LoginPage({super.key, this.goToSignUp});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passwordC = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: GestureDetector(
        onTap: () =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: MainContainer(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Image.asset(
                            loginIcon,
                            height: 100,
                          ),
                          SizedBox(height: 10),
                          Text(
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .h3
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            'Login',
                          ),
                          SizedBox(height: 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: 250,
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b2
                                    .fontSize,
                                fontWeight:
                                    FontWeight.normal,
                              ),
                              'Enter your details below to Log Into your Agent Account',
                            ),
                          ),
                          SizedBox(height: 20),
                          MyTextFieldMain(
                            isPassword: false,
                            controller: emailC,
                            isEmail: true,
                            showTitle: false,
                            isNumber: false,
                            isOptional: false,
                            hintText: 'Enter Email',
                            validatorText:
                                'Email Field Cannot be Empty!',
                          ),
                          SizedBox(height: 15),
                          MyTextFieldMain(
                            lines: 1,
                            onSubmit: (value) {
                              submitAction();
                            },
                            isPassword: true,
                            controller: passwordC,
                            isEmail: false,
                            showTitle: false,
                            isNumber: false,
                            isOptional: false,
                            hintText: 'Password',
                            validatorText:
                                'Password Field Cannot be Empty!',
                          ),
                          SizedBox(height: 10),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              mouseCursor:
                                  SystemMouseCursors.click,
                              onTap: widget.goToSignUp,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                children: [
                                  Text(
                                    style: TextStyle(
                                      fontSize: theme
                                          .mobileTexts
                                          .b2
                                          .fontSize,
                                    ),
                                    'Don\'t You Have An Account?',
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(
                                          5.0,
                                        ),
                                    child: Text(
                                      style: TextStyle(
                                        fontSize: theme
                                            .mobileTexts
                                            .b2
                                            .fontSize,
                                        fontWeight:
                                            FontWeight.bold,
                                        color: theme
                                            .lightModeColor
                                            .secColor200,
                                      ),
                                      'Create Account'
                                          .toUpperCase(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
                PrimaryButton(
                  isLoading: isLoading,
                  title: 'Login',
                  action: () async {
                    submitAction();
                  },
                ),
                SizedBox(height: 10),
                SecondaryButton(
                  title: 'Go Back',
                  action: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      widget.goToSignUp!();
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitAction() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      var res = await AuthService().signIn(
        emailC.text,
        passwordC.text,
      );
      if (res == 0) {
        setState(() {
          isLoading = false;
        });
        showSnackbar(
          actionResult: ActionResult().error,
          title: 'An Error Occoured',
          message:
              'Please check your email and Password, or your internet Connection and try again.',
          context: context,
        );
      } else {
        setState(() {
          isLoading = false;
        });
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return ValidateUserExists(
                  email: emailC.text.trim(),
                  password: passwordC.text.trim(),
                );
              },
            ),
          );
        }
      }
    }
  }
}
