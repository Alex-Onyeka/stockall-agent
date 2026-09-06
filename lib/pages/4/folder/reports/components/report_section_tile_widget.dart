import 'package:flutter/material.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class ReportSectionTileWidget extends StatelessWidget {
  const ReportSectionTileWidget({
    super.key,
    required this.theme,
    required this.title,
    required this.value,
  });

  final ThemeProvider theme;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(14, 245, 245, 245),
      ),
      child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            style: TextStyle(
              fontSize: theme.mobileTexts.b4.fontSize,
              color: Colors.white,
            ),
            "$title:",
          ),
          Text(
            style: TextStyle(
              fontSize: theme.mobileTexts.b3.fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            value,
          ),
        ],
      ),
    );
  }
}
