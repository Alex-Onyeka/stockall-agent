import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/4/folder/profile.dart';
import 'package:stockallagent/pages/4/folder/reports/reports.dart';

class FourthPage extends StatelessWidget {
  final Function()? popPage;
  final Function()? profileNavigationAction;
  const FourthPage({
    super.key,
    this.popPage,
    this.profileNavigationAction,
  });

  @override
  Widget build(BuildContext context) {
    if (returnAdminProvider(context: context).admin ==
        null) {
      return Profile(popPage: popPage);
    } else {
      return Reports(
        popPage: popPage,
        profileNavAction: profileNavigationAction,
      );
    }
  }
}
