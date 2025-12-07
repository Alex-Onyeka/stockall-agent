import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

class EmptyWidget extends StatelessWidget {
  final bool isDashboard;
  const EmptyWidget({super.key, required this.isDashboard});

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SizedBox(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            Icon(
              size: 30,
              color: isDashboard
                  ? Colors.white70
                  : Colors.grey.shade800,
              Icons.filter_list_off_sharp,
            ),
            Text(
              style: TextStyle(
                fontSize: theme.mobileTexts.h4.fontSize,
                fontWeight: FontWeight.bold,
                color: isDashboard
                    ? Colors.white70
                    : Colors.grey.shade800,
              ),
              "No Items Found",
            ),
          ],
        ),
      ),
    );
  }
}
