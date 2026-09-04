import 'package:flutter/material.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/4/delete_account.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding:
                            EdgeInsetsGeometry.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                        child: Icon(
                          size: 20,
                          color: Colors.grey.shade600,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b1.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    'Settings Page',
                  ),
                  Opacity(
                    opacity: 0,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        mouseCursor:
                            SystemMouseCursors.click,
                        onTap: () {},
                        child: Padding(
                          padding:
                              EdgeInsetsGeometry.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                          child: Icon(
                            size: 20,
                            color: Colors.grey.shade600,
                            Icons
                                .arrow_back_ios_new_rounded,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                padding: const EdgeInsets.symmetric(
                  // horizontal: 20.0,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  children: [
                    SettingsTile(
                      icon: Icons
                          .security_update_warning_rounded,
                      title: 'Change Password',
                      action: () {},
                    ),
                    SettingsTile(
                      icon: Icons.attach_email_outlined,
                      title: 'Change Email',
                      action: () {},
                    ),
                    SettingsTile(
                      icon: Icons.settings,
                      title: 'Delete Account',
                      action: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return DialogTemplate(
                              title: 'Are you sure?',
                              action: () async {
                                Navigator.of(
                                  dialogContext,
                                ).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return DeleteAccount();
                                    },
                                  ),
                                );
                              },
                              message:
                                  'Are you sure you want to Proceed to Delete Your Account and all its Data?',
                            );
                          },
                        );
                      },
                      color: const Color.fromARGB(
                        255,
                        204,
                        93,
                        93,
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
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? action;
  final Color? color;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    this.color,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: action,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade100,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                25,
                15,
                25,
                15,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Icon(
                        size: 20,
                        color:
                            color ?? Colors.grey.shade600,
                        icon,
                      ),
                      Text(
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.b2.fontSize,
                          color: color,
                        ),
                        title,
                      ),
                    ],
                  ),
                  Icon(
                    size: 20,
                    color: Colors.grey,
                    Icons.arrow_forward_ios_rounded,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
