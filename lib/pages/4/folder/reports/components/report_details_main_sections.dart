import 'package:flutter/material.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class ReportDetailsMainSection extends StatelessWidget {
  const ReportDetailsMainSection({
    super.key,
    required this.theme,
    required this.title,
    required this.widget,
  });

  final ThemeProvider theme;
  final String title;
  final List<Widget> widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        spacing: 5,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              Text(
                style: TextStyle(
                  fontSize: theme.mobileTexts.b3.fontSize,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                title.toUpperCase(),
              ),
            ],
          ),
          Divider(height: 15, color: Colors.white38),
          Column(spacing: 5, children: [...widget]),
        ],
      ),
    );
  }
}
