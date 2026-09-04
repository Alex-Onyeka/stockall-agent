import 'package:flutter/material.dart';
import 'package:stockallagent/constants/constants_main.dart';

class MainContainer extends StatelessWidget {
  final Widget child;
  const MainContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: isMobile(context)
            ? screenHeight(context)
            : screenHeight(context) - 50,
        constraints: BoxConstraints(maxWidth: 800),
        padding: isMobile(context)
            ? EdgeInsets.fromLTRB(20, 0, 20, 0)
            : EdgeInsets.fromLTRB(20, 30, 20, 10),
        decoration: BoxDecoration(
          color: isMobile(context) ? null : Colors.white,
          borderRadius: isMobile(context)
              ? null
              : BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: isMobile(context)
                  ? Colors.transparent
                  : const Color.fromARGB(20, 0, 0, 0),
              blurRadius: isMobile(context) ? 0 : 10,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
