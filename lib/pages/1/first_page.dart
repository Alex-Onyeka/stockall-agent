import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/1/platforms/dashboard_admin.dart';
import 'package:stockallagent/pages/1/platforms/dashboard_agent.dart';

class FirstPage extends StatelessWidget {
  final Function()? navigate;
  final Function()? profileNavAction;
  const FirstPage({
    super.key,
    this.navigate,
    this.profileNavAction,
  });

  @override
  Widget build(BuildContext context) {
    if (returnAdminProvider(context: context).admin ==
        null) {
      return DashboardAgent(
        navigate: navigate,
        profileNavAction: profileNavAction,
      );
    } else {
      return DashboardAdmin(
        navigate: navigate,
        profileNavAction: profileNavAction,
      );
    }
  }
}
