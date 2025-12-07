import 'package:flutter/material.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/buttons/secondary_button.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/confirm_email.dart';
import 'package:stockallagent/service/auth_service.dart';

class SignUpPage extends StatefulWidget {
  final Function()? goToLogin;
  const SignUpPage({super.key, this.goToLogin});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final firstNameC = TextEditingController();
  final lastNameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneNumberC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: GestureDetector(
        onTap: () =>
            FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Image.asset(
                              loginIconTwo,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .h3
                                    .fontSize,
                                fontWeight: FontWeight.bold,
                              ),
                              'Create Account',
                            ),
                            SizedBox(height: 5),
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
                                'Enter your details below to create your Agent Account',
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              spacing: 10,
                              children: [
                                Expanded(
                                  child: MyTextFieldMain(
                                    isPassword: false,
                                    controller: firstNameC,
                                    isEmail: false,
                                    showTitle: false,
                                    isNumber: false,
                                    isOptional: false,
                                    hintText: 'First Name',
                                    validatorText:
                                        'First Name Cannot be Empty!',
                                  ),
                                ),
                                Expanded(
                                  child: MyTextFieldMain(
                                    isPassword: false,
                                    controller: lastNameC,
                                    isEmail: false,
                                    showTitle: false,
                                    isNumber: false,
                                    isOptional: true,
                                    hintText: 'Last Name',
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
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
                              isPassword: false,
                              controller: phoneNumberC,
                              isEmail: false,
                              showTitle: false,
                              isNumber: true,
                              isOptional: false,
                              hintText:
                                  'Enter Phone Number',
                              validatorText:
                                  'Phone Number Cannot be Empty!',
                            ),
                            SizedBox(height: 15),
                            MyTextFieldMain(
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
                            SizedBox(height: 15),
                            MyTextFieldMain(
                              isPassword: true,
                              controller: confirmPasswordC,
                              isEmail: false,
                              showTitle: false,
                              isNumber: false,
                              isOptional: false,
                              hintText: 'Confirm Password',
                              validatorText:
                                  'Confirm Password Field Cannot be Empty!',
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b2
                                        .fontSize,
                                  ),
                                  'Do You Have An Account?',
                                ),
                                InkWell(
                                  onTap: widget.goToLogin,
                                  child: Padding(
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
                                      'LOGIN',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                  PrimaryButton(
                    isLoading: isLoading,
                    title: 'Create Account',
                    action: () async {
                      if (formKey.currentState!
                          .validate()) {
                        if (!isValidEmail(emailC.text)) {
                          showSnackbar(
                            message:
                                'The email you entered is invalid. Please enter a valid email address. Thank you',
                            title: 'Invalid email Address',
                            context: context,
                            actionResult:
                                ActionResult().error,
                          );
                        } else if (passwordC.text.length <
                            6) {
                          showSnackbar(
                            message:
                                'Your Password is less than 6 characters, therefore, it is too short... Choose a password that\'s long',
                            title: 'Weak Password',
                            context: context,
                            actionResult:
                                ActionResult().error,
                          );
                        } else if (confirmPasswordC.text !=
                            passwordC.text) {
                          showSnackbar(
                            message:
                                'Your Password and confirm password field values are not the same.',
                            title: 'Password Mismatch',
                            context: context,
                            actionResult:
                                ActionResult().error,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          var res = await AuthService()
                              .signUpAndCreateUser(
                                context: context,
                                email: emailC.text.trim(),
                                password: passwordC.text,
                              );

                          if (res.user == null &&
                              context.mounted) {
                            setState(() {
                              isLoading = false;
                            });
                            showSnackbar(
                              message:
                                  'An error occured while creating your agent account, please check your internet connection and try again.',
                              title: 'An Error Occured',
                              context: context,
                              actionResult:
                                  ActionResult().error,
                            );
                          } else {
                            if (context.mounted) {
                              showSnackbar(
                                message:
                                    'Your account has been created successfully. Please proceed to verify your account.',
                                title:
                                    'Account Created Success',
                                context: context,
                                actionResult:
                                    ActionResult().success,
                              );
                              await Future.delayed(
                                Duration(seconds: 2),
                                () {},
                              );
                              if (context.mounted) {
                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ConfirmEmail(
                                        user: UserClass(
                                          userId:
                                              res.user!.id,
                                          password:
                                              passwordC
                                                  .text,
                                          name: firstNameC
                                              .text
                                              .trim(),
                                          email: emailC.text
                                              .trim(),
                                          lastName:
                                              lastNameC
                                                  .text,
                                          phone:
                                              phoneNumberC
                                                  .text
                                                  .trim(),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }
                            }
                          }
                        }
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  SecondaryButton(
                    title: 'Go Back',
                    action: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
