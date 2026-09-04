import 'package:flutter/material.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/components/buttons/primary_button.dart';
import 'package:stockallagent/components/buttons/secondary_button.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/base_page.dart';
import 'package:stockallagent/service/auth_service.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() =>
      _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool isLoading = false;
  final passwordC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 200,
                      ),
                      child: Text(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.h3.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        'Enter Password',
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 5),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 240,
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b3
                                  .fontSize,
                              fontWeight: FontWeight.normal,
                            ),
                            'Please enter your password below to delete your account',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 2.5,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: theme
                            .lightModeColor
                            .secColor200,
                      ),
                    ),
                    SizedBox(height: 15),
                    Form(
                      key: formKey,
                      child: MyTextFieldMain(
                        controller: passwordC,
                        isEmail: false,
                        showTitle: false,
                        isNumber: false,
                        isOptional: false,
                        hintText: 'Enter Password',
                        isPassword: true,
                        validatorText:
                            'Password Field Cannot be empty',
                      ),
                    ),
                    SizedBox(height: 30),
                    PrimaryButton(
                      action: () async {
                        if (formKey.currentState!
                            .validate()) {
                          if (passwordC.text ==
                              returnUserProvider()
                                  .currentUser
                                  ?.password) {
                            setState(() {
                              isLoading = true;
                            });
                            await AuthService()
                                .deleteUserAccount(context);
                            if (context.mounted) {
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
                                  'The Password you just entered is incorrect. Please enter your account password before you can delete your account.',
                              title: 'Password Incorrect!',
                              context: context,
                              actionResult:
                                  ActionResult().error,
                            );
                          }
                        }
                      },
                      isLoading: isLoading,
                      title: 'Proceed to Delete Account',
                    ),
                    SizedBox(height: 15),
                    SecondaryButton(
                      title: 'Cancel',
                      action: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
