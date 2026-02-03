import 'package:flutter/material.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/buttons/secondary_button.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/base_page.dart';
import 'package:stockallagent/pages/authentication/sign_up_page.dart';
import 'package:stockallagent/pages/authentication/welcome_screen.dart';
import 'package:stockallagent/service/auth_service.dart';

class SetUpProfile extends StatefulWidget {
  final String email;
  final String password;
  const SetUpProfile({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  final firstNameC = TextEditingController();
  final lastNameC = TextEditingController();
  final phoneNumberC = TextEditingController();

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
                              profileIcon,
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
                              'Set Up Your Profile',
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
                                'Enter your details below to complete your Agent Account Set up',
                              ),
                            ),
                            SizedBox(height: 15),
                            MyTextFieldMain(
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
                            SizedBox(height: 10),
                            MyTextFieldMain(
                              isPassword: false,
                              controller: lastNameC,
                              isEmail: false,
                              showTitle: false,
                              isNumber: false,
                              isOptional: true,
                              hintText: 'Last Name',
                            ),
                            SizedBox(height: 10),
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
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              spacing: 5,
                              children: [
                                Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b2
                                        .fontSize,
                                  ),
                                  'Select Role:',
                                ),
                                Row(
                                  spacing: 10,
                                  mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                  children:
                                      returnUserProvider(
                                            context:
                                                context,
                                          ).roles
                                          .map(
                                            (role) =>
                                                RoleSelectionWidget(
                                                  role:
                                                      role,
                                                ),
                                          )
                                          .toList(),
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
                    title: 'Create Profile',
                    action: () async {
                      if (formKey.currentState!
                          .validate()) {
                        if (returnUserProvider(
                          context: context,
                          listen: false,
                        ).selectedRole.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (confirmDialog) {
                              return DialogTemplate(
                                action: () async {
                                  Navigator.of(
                                    confirmDialog,
                                  ).pop();
                                  var user = UserClass(
                                    password:
                                        widget.password,
                                    name: firstNameC.text,
                                    lastName:
                                        lastNameC.text,
                                    email: widget.email,
                                    phone:
                                        phoneNumberC.text,
                                    role:
                                        returnUserProvider(
                                          context: context,
                                          listen: false,
                                        ).selectedRole,
                                    userId: AuthService()
                                        .currentUser!
                                        .id,
                                  );
                                  setState(() {
                                    isLoading = true;
                                  });
                                  var res =
                                      await returnUserProvider(
                                        context: context,
                                        listen: false,
                                      ).createAgent(user);

                                  if (res == 0) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    showSnackbar(
                                      message:
                                          'An error occured while creating your agent account, please check your internet connection and try again.',
                                      title:
                                          'An Error Occured',
                                      context: context,
                                      actionResult:
                                          ActionResult()
                                              .error,
                                    );
                                  } else {
                                    if (context.mounted) {
                                      showSnackbar(
                                        message:
                                            'Your account has been created successfully. Proceed to your Dashboard to commence your operations',
                                        title:
                                            'Account Created Success',
                                        context: context,
                                        actionResult:
                                            ActionResult()
                                                .success,
                                      );
                                      await Future.delayed(
                                        Duration(
                                          seconds: 2,
                                        ),
                                        () {},
                                      );
                                      if (context.mounted) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return BasePage();
                                            },
                                          ),
                                        );
                                      }
                                    } else {
                                      showSnackbar(
                                        message:
                                            'An error occured while creating your agent account, Refresh this page and try again',
                                        title:
                                            'An Error Occured',
                                        context: context,
                                        actionResult:
                                            ActionResult()
                                                .error,
                                      );
                                    }
                                  }
                                },
                                cancelActionText: 'Cancel',
                                mainActionText: 'Proceed',
                                title:
                                    'Proceed with Action?',
                                message:
                                    'Are you sure you want to proceed with setting up your account?',
                              );
                            },
                          );
                        } else {
                          showSnackbar(
                            message:
                                'You must select your agent role before you can proceed to finish setting up your agent account.',
                            title: 'Select a Role',
                            context: context,
                            actionResult:
                                ActionResult().error,
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 10),
                  SecondaryButton(
                    title: 'Logout',
                    action: () async {
                      await AuthService().signOut(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomeScreen();
                          },
                        ),
                      );
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
