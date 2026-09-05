import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/1/platforms/dashboard_admin.dart';
import 'package:stockallagent/pages/1/platforms/dashboard_agent.dart';

class FirstPage extends StatefulWidget {
  final Function()? navigate;
  final Function()? profileNavAction;
  const FirstPage({
    super.key,
    this.navigate,
    this.profileNavAction,
  });

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnShopProvider().getShops();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (returnAdminProvider(context: context).admin ==
        null) {
      return DashboardAgent(
        navigate: widget.navigate,
        profileNavAction: widget.profileNavAction,
      );
    } else {
      return DashboardAdmin(
        navigate: widget.navigate,
        profileNavAction: widget.profileNavAction,
      );
    }
  }
}
