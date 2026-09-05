import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/2/platforms/second_page_alt.dart';
import 'package:stockallagent/pages/3/folders/agents.dart';

class ThirdPage extends StatelessWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const ThirdPage({
    super.key,
    this.profileNavAction,
    this.popPage,
  });
  @override
  Widget build(BuildContext context) {
    if (!topAdmin()) {
      // return Payments(
      //   popPage: popPage,
      //   profileNavAction: profileNavAction,
      // );
      return SecondPageAlt(
        agentUuid: returnUserProvider().currentUser?.userId,
      );
    } else {
      return Agents(
        popPage: popPage,
        profileNavAction: profileNavAction,
      );
    }
  }
}
