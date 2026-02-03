import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/3/folders/agents.dart';
import 'package:stockallagent/pages/3/folders/payments.dart';

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
    if (returnAdminProvider(context: context).admin ==
        null) {
      return Payments(
        popPage: popPage,
        profileNavAction: profileNavAction,
      );
    } else {
      return Agents(
        popPage: popPage,
        profileNavAction: profileNavAction,
      );
    }
  }
}
