import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stockallagent/classes/action_result.dart';
import 'package:stockallagent/classes/bank_class.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/components/textfields/my_text_field.dart';
import 'package:stockallagent/constants/comp_constants.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/base_page.dart';
import 'package:stockallagent/pages/settings_page.dart/settings_page.dart';
import 'package:stockallagent/service/auth_service.dart';

class Profile extends StatefulWidget {
  final Function()? popPage;
  const Profile({super.key, this.popPage});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final accountNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        widget.popPage!();
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            return returnUserProvider().getUser();
          },
          backgroundColor: Colors.white,
          color: theme.lightModeColor.prColor250,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SettingsPage();
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 10,
                      ),
                      child: Icon(
                        size: 20,
                        color: Colors.grey.shade700,
                        Icons.settings,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade300,
                ),
                child: Image.asset(profileIcon, height: 90),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.fromLTRB(
                  20,
                  10,
                  20,
                  20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(
                        5,
                        0,
                        0,
                        0,
                      ),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  spacing: 5,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          style: TextStyle(
                            fontSize: theme
                                .mobileTexts
                                .b1
                                .fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          'Account Information',
                        ),
                        Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            mouseCursor:
                                SystemMouseCursors.click,
                            borderRadius:
                                BorderRadius.circular(5),
                            onTap: () {
                              var user =
                                  returnUserProvider()
                                      .currentUser!;
                              nameController.text =
                                  user.name;
                              phoneController.text =
                                  user.phone!;
                              lastNameController.text =
                                  user.lastName ?? '';
                              showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return DialogTemplate(
                                    title: 'Edit Profile',
                                    action: () async {
                                      if (formKey
                                          .currentState!
                                          .validate()) {
                                        var newUser = UserClass(
                                          roleId:
                                              user.roleId,
                                          password:
                                              user.password,
                                          name:
                                              nameController
                                                  .text
                                                  .trim(),
                                          email: user.email,
                                          lastName:
                                              lastNameController
                                                  .text
                                                  .trim(),
                                          phone:
                                              phoneController
                                                  .text
                                                  .trim(),
                                        );
                                        returnResourceProvider()
                                            .toggleLoading(
                                              true,
                                            );
                                        var res =
                                            await returnUserProvider()
                                                .updateUser(
                                                  newUser,
                                                );

                                        if (res == 0 &&
                                            context
                                                .mounted) {
                                          returnResourceProvider()
                                              .toggleLoading(
                                                false,
                                              );
                                          showSnackbar(
                                            message:
                                                'An Error occoured while updating your information, please check your internet and try again.',
                                            title:
                                                'An Error Occured',
                                            context:
                                                context,
                                            actionResult:
                                                ActionResult()
                                                    .error,
                                          );
                                        } else {
                                          if (context
                                              .mounted) {
                                            returnResourceProvider()
                                                .toggleLoading(
                                                  false,
                                                );
                                            Navigator.of(
                                              dialogContext,
                                            ).pop();
                                            showSnackbar(
                                              message:
                                                  'Your Profile has been updated successfully.',
                                              title:
                                                  'Profile Updated Successfully',
                                              context:
                                                  context,
                                              actionResult:
                                                  ActionResult()
                                                      .success,
                                            );
                                          }
                                        }
                                      }
                                    },
                                    mainActionText:
                                        'Save Details',
                                    subTitle:
                                        'Enter details below and save to update your Account.',
                                    mainWidget: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisSize:
                                            MainAxisSize
                                                .min,
                                        children: [
                                          Row(
                                            spacing: 5,
                                            children: [
                                              Expanded(
                                                child: MyTextFieldMain(
                                                  isPassword:
                                                      false,
                                                  title:
                                                      'First Name',
                                                  hintText:
                                                      'First Name',
                                                  isOptional:
                                                      false,
                                                  isNumber:
                                                      false,
                                                  controller:
                                                      nameController,
                                                  isEmail:
                                                      false,
                                                  showTitle:
                                                      true,
                                                  validatorText:
                                                      'First Name Cannot be empty!',
                                                ),
                                              ),
                                              Expanded(
                                                child: MyTextFieldMain(
                                                  isPassword:
                                                      false,
                                                  title:
                                                      'Last Name',
                                                  hintText:
                                                      'Last Name',
                                                  isOptional:
                                                      true,
                                                  isNumber:
                                                      false,
                                                  controller:
                                                      lastNameController,
                                                  isEmail:
                                                      false,
                                                  showTitle:
                                                      true,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          MyTextFieldMain(
                                            isPassword:
                                                false,
                                            title:
                                                'Phone Number',
                                            hintText:
                                                'Enter Phone Number',
                                            isOptional:
                                                false,
                                            isNumber: true,
                                            controller:
                                                phoneController,
                                            isEmail: false,
                                            showTitle: true,
                                            validatorText:
                                                'Phone Number Cannot be empty!',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).then((_) {
                                nameController.clear();
                                phoneController.clear();
                                emailController.clear();
                                lastNameController.clear();
                                if (context.mounted) {
                                  returnResourceProvider()
                                      .toggleLoading(false);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(
                                      5,
                                    ),
                              ),
                              child: Icon(
                                size: 18,
                                Icons.edit_outlined,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(height: 1),
                    Column(
                      children: [
                        InfoSections(
                          mainInfo:
                              "${returnUserProvider(context: context).currentUser?.name ?? 'User Name'} ${returnUserProvider(context: context).currentUser?.lastName ?? ''}",
                          title: 'Name',
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey.shade200,
                          // endIndent: 50,
                          // indent: 50,
                        ),
                        InfoSections(
                          mainInfo:
                              returnUserProvider(
                                context: context,
                              ).currentUser?.email ??
                              'User Email',
                          title: 'Email',
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey.shade200,
                          // endIndent: 50,
                          // indent: 50,
                        ),
                        InfoSections(
                          mainInfo:
                              returnUserProvider(
                                context: context,
                              ).currentUser?.phone ??
                              'User Phone',
                          title: 'Phone',
                        ),
                        Divider(
                          height: 25,
                          color: Colors.grey.shade200,
                          // endIndent: 50,
                          // indent: 50,
                        ),
                        Visibility(
                          visible:
                              returnAdminProvider(
                                context: context,
                              ).admin ==
                              null,
                          child: InfoSections(
                            copyAction: () {
                              print('Copying shit');
                              Clipboard.setData(
                                ClipboardData(
                                  text:
                                      returnUserProvider()
                                          .currentUser
                                          ?.referralCode ??
                                      'User Ref Code',
                                ),
                              );

                              showSnackbar(
                                message:
                                    'Your Referral Code has been copied to clipboard.',
                                title:
                                    'Copied to Clipboard!',
                                context: context,
                                actionResult:
                                    ActionResult().success,
                              );
                            },
                            titleBoxWidth: 50,
                            mainInfo:
                                returnUserProvider(
                                      context: context,
                                    )
                                    .currentUser
                                    ?.referralCode
                                    ?.toUpperCase() ??
                                'Referral Code',
                            title: 'Ref. Code',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Visibility(
                visible:
                    returnAdminProvider(
                      context: context,
                    ).admin ==
                    null,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    20,
                    10,
                    20,
                    20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(
                          5,
                          0,
                          0,
                          0,
                        ),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    spacing: 5,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            spacing: 5,
                            children: [
                              Text(
                                style: TextStyle(
                                  fontSize: theme
                                      .mobileTexts
                                      .b1
                                      .fontSize,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                                'Bank Information',
                              ),
                              Visibility(
                                visible:
                                    returnBankProvider(
                                      context: context,
                                    ).bank ==
                                    null,
                                child: Text(
                                  style: TextStyle(
                                    fontSize: theme
                                        .mobileTexts
                                        .b2
                                        .fontSize,
                                    color: Colors.redAccent,
                                    fontWeight:
                                        FontWeight.normal,
                                    fontStyle:
                                        FontStyle.italic,
                                  ),
                                  "(Not Set)",
                                ),
                              ),
                            ],
                          ),
                          Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              mouseCursor:
                                  SystemMouseCursors.click,
                              borderRadius:
                                  BorderRadius.circular(5),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) {
                                    var bank =
                                        returnBankProvider()
                                            .bank;
                                    if (bank != null) {
                                      bankNameController
                                              .text =
                                          bank.bankName;
                                      accountNameController
                                              .text =
                                          bank.accountName;
                                      accountNumberController
                                          .text = bank
                                          .accountNumber;
                                    }
                                    return DialogTemplate(
                                      title:
                                          returnBankProvider()
                                                  .bank ==
                                              null
                                          ? "Create New Bank"
                                          : 'Edit Bank Detials',
                                      action: () async {
                                        var newBank = BankClass(
                                          bankId:
                                              returnBankProvider()
                                                  .bank
                                                  ?.bankId,
                                          bankName:
                                              bankNameController
                                                  .text
                                                  .trim(),
                                          accountName:
                                              accountNameController
                                                  .text
                                                  .trim(),
                                          accountNumber:
                                              accountNumberController
                                                  .text
                                                  .trim(),
                                          userId: AuthService()
                                              .currentUser!
                                              .id,
                                        );
                                        if (formKey
                                            .currentState!
                                            .validate()) {
                                          if (returnBankProvider()
                                                  .bank ==
                                              null) {
                                            returnResourceProvider()
                                                .toggleLoading(
                                                  true,
                                                );
                                            var res = await returnBankProvider()
                                                .createBank(
                                                  newBank,
                                                );
                                            if (res == 0 &&
                                                context
                                                    .mounted) {
                                              returnResourceProvider()
                                                  .toggleLoading(
                                                    false,
                                                  );
                                              showSnackbar(
                                                actionResult:
                                                    ActionResult()
                                                        .error,
                                                message:
                                                    'An Error Occured while creating your bank. Please check your internet and try again.',
                                                title:
                                                    'An Error Occoured',
                                                context:
                                                    context,
                                              );
                                            } else {
                                              Navigator.of(
                                                // ignore: use_build_context_synchronously
                                                dialogContext,
                                              ).pop();
                                              if (context
                                                  .mounted) {
                                                showSnackbar(
                                                  actionResult:
                                                      ActionResult()
                                                          .success,
                                                  message:
                                                      'Your bank has been added successfully. You can start receiving payments now.',
                                                  title:
                                                      "Bank Added Successfully",
                                                  context:
                                                      context,
                                                );
                                              } else {
                                                print(
                                                  'Context is not Mounted',
                                                );
                                              }
                                            }
                                          } else {
                                            returnResourceProvider()
                                                .toggleLoading(
                                                  true,
                                                );
                                            var res = await returnBankProvider()
                                                .updateBank(
                                                  newBank,
                                                );
                                            if (res == 0 &&
                                                context
                                                    .mounted) {
                                              returnResourceProvider()
                                                  .toggleLoading(
                                                    false,
                                                  );
                                              showSnackbar(
                                                actionResult:
                                                    ActionResult()
                                                        .error,
                                                message:
                                                    'An Error Occured while Updating your bank. Please check your internet and try again.',
                                                title:
                                                    'An Error Occoured',
                                                context:
                                                    context,
                                              );
                                            } else {
                                              Navigator.of(
                                                // ignore: use_build_context_synchronously
                                                dialogContext,
                                              ).pop();
                                              if (context
                                                  .mounted) {
                                                showSnackbar(
                                                  actionResult:
                                                      ActionResult()
                                                          .success,
                                                  message:
                                                      'Your bank has been Updated successfully. You can start receiving payments now.',
                                                  title:
                                                      "Bank Updated Successfully",
                                                  context:
                                                      context,
                                                );
                                              } else {
                                                print(
                                                  'Context is not Mounted',
                                                );
                                              }
                                            }
                                          }
                                        }
                                      },
                                      mainActionText:
                                          returnBankProvider()
                                                  .bank ==
                                              null
                                          ? "Create Bank"
                                          : 'Update Bank',
                                      subTitle:
                                          returnBankProvider()
                                                  .bank ==
                                              null
                                          ? "Enter details below and save to Create your Bank."
                                          : 'Enter details below and save to update your Bank.',
                                      mainWidget: Form(
                                        key: formKey,
                                        child: Column(
                                          mainAxisSize:
                                              MainAxisSize
                                                  .min,
                                          children: [
                                            MyTextFieldMain(
                                              isPassword:
                                                  false,
                                              title:
                                                  'Account Name',
                                              hintText:
                                                  'Enter Account Name',
                                              isOptional:
                                                  false,
                                              isNumber:
                                                  false,
                                              controller:
                                                  accountNameController,
                                              isEmail:
                                                  false,
                                              showTitle:
                                                  true,
                                              validatorText:
                                                  'Account Name Cannot be empty!',
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            MyTextFieldMain(
                                              isPassword:
                                                  false,
                                              title:
                                                  'Bank Name',
                                              hintText:
                                                  'Enter Bank Name',
                                              isOptional:
                                                  false,
                                              isNumber:
                                                  false,
                                              controller:
                                                  bankNameController,
                                              isEmail:
                                                  false,
                                              showTitle:
                                                  true,
                                              validatorText:
                                                  'Bank Name Cannot be empty!',
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            MyTextFieldMain(
                                              isPassword:
                                                  false,
                                              title:
                                                  'Account Number',
                                              hintText:
                                                  'Enter Account No.',
                                              isOptional:
                                                  false,
                                              isNumber:
                                                  true,
                                              controller:
                                                  accountNumberController,
                                              isEmail:
                                                  false,
                                              showTitle:
                                                  true,
                                              validatorText:
                                                  'Account Number Cannot be empty!',
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ).then((_) {
                                  bankNameController
                                      .clear();
                                  accountNameController
                                      .clear();
                                  accountNumberController
                                      .clear();
                                  if (context.mounted) {
                                    returnResourceProvider()
                                        .toggleLoading(
                                          false,
                                        );
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(
                                        5,
                                      ),
                                ),
                                child: Icon(
                                  size: 18,
                                  Icons.edit_outlined,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      SizedBox(height: 1),
                      Column(
                        children: [
                          InfoSections(
                            titleBoxWidth: 90,
                            mainInfo:
                                returnBankProvider(
                                  context: context,
                                ).bank?.accountName ??
                                'Not Set',
                            title: 'Account Name',
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey.shade200,
                            // endIndent: 50,
                            // indent: 50,
                          ),
                          InfoSections(
                            titleBoxWidth: 60,
                            mainInfo:
                                returnBankProvider(
                                  context: context,
                                ).bank?.bankName ??
                                'Not Set',
                            title: 'Bank Name',
                          ),
                          Divider(
                            height: 25,
                            color: Colors.grey.shade200,
                            // endIndent: 50,
                            // indent: 50,
                          ),
                          InfoSections(
                            titleBoxWidth: 60,
                            mainInfo:
                                returnBankProvider(
                                  context: context,
                                ).bank?.accountNumber ??
                                'Not Set',
                            title: 'Account No.',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Material(
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                    border: Border.all(
                      color: const Color.fromARGB(
                        34,
                        244,
                        67,
                        54,
                      ),
                    ),
                  ),
                  child: InkWell(
                    mouseCursor: SystemMouseCursors.click,
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      var safeContext = context;
                      showDialog(
                        context: context,
                        builder: (logoutContext) {
                          return DialogTemplate(
                            title: 'Are you sure?',
                            action: () async {
                              returnResourceProvider()
                                  .toggleLoading(true);
                              await AuthService().signOut(
                                safeContext,
                              );
                              if (logoutContext.mounted) {
                                Navigator.of(
                                  logoutContext,
                                ).pop();
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return BasePage();
                                  },
                                ),
                              );
                            },
                            message:
                                'Are you sure you want to Logout?',
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),

                      child: Center(
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              style: TextStyle(
                                fontSize: theme
                                    .mobileTexts
                                    .b2
                                    .fontSize,
                                color: Colors.red,
                              ),
                              'Log Out',
                            ),
                            Icon(
                              size: 18,
                              color: Colors.red,
                              Icons.logout_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoSections extends StatelessWidget {
  final String title;
  final String mainInfo;
  final double? titleBoxWidth;
  final Function()? copyAction;
  const InfoSections({
    super.key,
    required this.title,
    required this.mainInfo,
    this.titleBoxWidth,
    this.copyAction,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 10,
      children: [
        SizedBox(
          width: titleBoxWidth ?? 30,
          child: Text(
            style: TextStyle(
              fontSize: theme.mobileTexts.b4.fontSize,
              fontWeight: FontWeight.normal,
            ),
            "$title:",
          ),
        ),
        Flexible(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              mouseCursor: SystemMouseCursors.click,
              onTap: copyAction,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: copyAction != null,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(size: 16, Icons.copy),
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b3.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    mainInfo,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
