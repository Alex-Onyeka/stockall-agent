import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final Function()? action;

  const SecondaryButton({
    super.key,
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
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.shade200,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: action,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),

            child: Center(
              child: Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b2.fontSize,
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
