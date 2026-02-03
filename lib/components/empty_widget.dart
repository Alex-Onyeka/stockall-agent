import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';

class EmptyWidget extends StatelessWidget {
  final bool isDashboard;
  final String? title;
  const EmptyWidget({
    super.key,
    required this.isDashboard,
    this.title,
  });

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
              size: 25,
              color: isDashboard
                  ? Colors.white70
                  : Colors.grey.shade800,
              Icons.filter_list_off_sharp,
            ),
            Text(
              style: TextStyle(
                fontSize: theme.mobileTexts.b1.fontSize,
                fontWeight: FontWeight.normal,
                color: isDashboard
                    ? Colors.white70
                    : Colors.grey.shade800,
              ),
              "No ${title ?? 'Item'} Found",
            ),
          ],
        ),
      ),
    );
  }
}
