import 'package:flutter/material.dart';
import 'package:stockallagent/classes/user_class.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/authentication/set_up_profile.dart';
import 'package:stockallagent/pages/home/home.dart';

class ValidateUserExists extends StatefulWidget {
  final String email;
  final String password;
  const ValidateUserExists({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<ValidateUserExists> createState() =>
      _ValidateUserExistsState();
}

class _ValidateUserExistsState
    extends State<ValidateUserExists> {
  @override
  void initState() {
    super.initState();
    userFuture = getUserFuture();
  }

  late Future<UserClass?> userFuture;

  Future<UserClass?> getUserFuture() async {
    return await returnUserProvider(
      context: context,
      listen: false,
    ).getUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState ==
            ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('An Error Occured.')),
          );
        } else {
          if (snapshot.data == null) {
            return SetUpProfile(
              email: widget.email,
              password: widget.password,
            );
          } else {
            return Home();
          }
        }
      },
    );
  }
}
