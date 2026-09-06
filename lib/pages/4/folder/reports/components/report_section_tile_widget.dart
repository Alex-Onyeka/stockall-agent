import 'package:flutter/material.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class ReportSectionTileWidget extends StatefulWidget {
  const ReportSectionTileWidget({
    super.key,
    required this.theme,
    required this.title,
    required this.value,
    required this.value2,
  });

  final ThemeProvider theme;
  final String title;
  final String value;
  final String? value2;

  @override
  State<ReportSectionTileWidget> createState() =>
      _ReportSectionTileWidgetState();
}

class _ReportSectionTileWidgetState
    extends State<ReportSectionTileWidget> {
  Widget? analysisWidget() {
    double value1 = double.parse(widget.value);
    double? value2 = double.tryParse(widget.value2 ?? '');
    if (value2 == null) {
      return null;
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          spacing: 3,
          children: [
            Text(
              style: TextStyle(
                fontSize:
                    returnTheme().mobileTexts.b4.fontSize,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
              "( ${(value1 - value2)} )",
            ),
            Icon(
              size: 15,
              color: value1 > value2
                  ? Colors.green
                  : value1 < value2
                  ? Colors.redAccent
                  : Colors.grey,
              value1 > value2
                  ? Icons.arrow_upward_rounded
                  : value1 < value2
                  ? Icons.arrow_downward_rounded
                  : Icons.minimize_outlined,
            ),
          ],
        ),
      );
    }
  }

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
              fontSize:
                  widget.theme.mobileTexts.b4.fontSize,
              color: Colors.white,
            ),
            "${widget.title}:",
          ),
          Row(
            children: [
              Text(
                style: TextStyle(
                  fontSize:
                      widget.theme.mobileTexts.b3.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                widget.value,
              ),
              analysisWidget() ?? Container(),
            ],
          ),
        ],
      ),
    );
  }
}
