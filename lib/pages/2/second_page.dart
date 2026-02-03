import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/platforms/second_page_admin.dart';
import 'package:stockallagent/pages/2/platforms/second_page_agent.dart';

class SecondPage extends StatelessWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const SecondPage({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  Widget build(BuildContext context) {
    if (returnAdminProvider(context: context).admin ==
        null) {
      return SecondPageAgent(
        popPage: popPage,
        profileNavAction: profileNavAction,
      );
    } else {
      return SecondPageAdmin(
        popPage: popPage,
        profileNavAction: profileNavAction,
      );
    }
  }
}

class TopStoreFilterButton extends StatelessWidget {
  final int myIndex;
  final int mainIndex;
  final String title;
  final Function()? action;

  const TopStoreFilterButton({
    super.key,
    required this.myIndex,
    required this.mainIndex,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: mainIndex == myIndex
                ? theme.lightModeColor.prColor300
                : null,
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: action,
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 7,
                horizontal: 5,
              ),

              child: Center(
                child: Text(
                  style: TextStyle(
                    fontSize: theme.mobileTexts.b4.fontSize,
                    fontWeight: mainIndex == myIndex
                        ? FontWeight.bold
                        : null,
                    color: mainIndex == myIndex
                        ? Colors.white
                        : theme.lightModeColor.prColor300,
                  ),
                  title,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
