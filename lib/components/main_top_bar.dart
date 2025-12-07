import 'package:flutter/material.dart';
import 'package:stockallagent/components/dialog_template.dart';
import 'package:stockallagent/constants/media_links.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/service/auth_service.dart';

class MainTopBar extends StatefulWidget {
  final Function()? profileNavAction;
  const MainTopBar({super.key, this.profileNavAction});

  @override
  State<MainTopBar> createState() => _MainTopBarState();
}

class _MainTopBarState extends State<MainTopBar> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10,
        children: [
          Material(
            type: MaterialType.transparency,
            child: Ink(
              color: Colors.white,
              child: InkWell(
                onTap: widget.profileNavAction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber,
                        ),
                        child: Image.asset(
                          profileIcon,
                          height: 30,
                        ),
                      ),
                      Text(
                        style: TextStyle(
                          fontSize:
                              theme.mobileTexts.b1.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        returnUserProvider(
                              context: context,
                            ).currentUser?.name ??
                            'User Name',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Ink(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(40),
                onTap: () {
                  var safeContext = context;
                  showDialog(
                    context: context,
                    builder: (logoutContext) {
                      return DialogTemplate(
                        title: 'Are you sure?',
                        action: () async {
                          returnResourceProvider(
                            context: context,
                            listen: false,
                          ).toggleLoading(true);
                          await AuthService().signOut(
                            safeContext,
                          );
                          if (logoutContext.mounted) {
                            Navigator.of(
                              logoutContext,
                            ).pop();
                          }
                        },
                        message:
                            'Are you sure you want to Logout?',
                      );
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    size: 20,
                    color: Colors.red,
                    Icons.logout_rounded,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
