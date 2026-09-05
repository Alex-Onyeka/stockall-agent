import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/platforms/second_page_admin.dart';
import 'package:stockallagent/pages/2/platforms/second_page_alt.dart';

class SecondPage extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  final String? agentUuid;
  const SecondPage({
    super.key,
    this.profileNavAction,
    this.popPage,
    this.agentUuid,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnShopProvider().getShops();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.agentUuid != null) {
      return SecondPageAlt(agentUuid: widget.agentUuid);
    } else {
      if (returnAdminProvider(context: context).admin ==
          null) {
        return SecondPageAlt(agentUuid: widget.agentUuid);
        // return SecondPageAgent(
        //   popPage: widget.popPage,
        //   profileNavAction: widget.profileNavAction,
        // );
      } else {
        return SecondPageAdmin(
          popPage: widget.popPage,
          profileNavAction: widget.profileNavAction,
        );
      }
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
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: mainIndex == myIndex
              ? theme.lightModeColor.prColor300
              : null,
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: action,
          child: Container(
            width: 110,
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
    );
  }
}
