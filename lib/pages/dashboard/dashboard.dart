import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/dashboard/platforms/dashboard_admin.dart';
import 'package:stockallagent/pages/dashboard/platforms/dashboard_agent.dart';

class Dashboard extends StatelessWidget {
  final Function()? navigate;
  final Function()? profileNavAction;
  const Dashboard({
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
