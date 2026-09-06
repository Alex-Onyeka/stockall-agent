import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/4/folder/reports/components/others_section_wigdet.dart';
import 'package:stockallagent/pages/4/folder/reports/components/stores_section_widget.dart';
import 'package:stockallagent/pages/4/folder/reports/components/subscription_general_widget.dart';
import 'package:stockallagent/pages/4/folder/reports/components/subscription_today_widget.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class ReportDetails extends StatelessWidget {
  final AnalysisReport report;
  final AnalysisReport? report2;
  const ReportDetails({
    super.key,
    required this.report,
    this.report2,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.lightModeColor.prColor300,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      mouseCursor: SystemMouseCursors.click,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding:
                            EdgeInsetsGeometry.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                        child: Icon(
                          size: 20,
                          color: Colors.grey.shade600,
                          Icons.arrow_back_ios_new_rounded,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    style: TextStyle(
                      fontSize:
                          theme.mobileTexts.b1.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    formatDate(report.createdAt),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        mouseCursor:
                            SystemMouseCursors.click,
                        onTap: () {},
                        child: Padding(
                          padding:
                              EdgeInsetsGeometry.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                          child: Icon(
                            size: 20,
                            color: Colors.grey.shade600,
                            Icons
                                .arrow_back_ios_new_rounded,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  20,
                  20,
                  20,
                ),
                child: SingleChildScrollView(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth >
                          mobileScreen) {
                        return DesktopView(
                          theme: theme,
                          report: report,
                          report2: report2,
                        );
                      } else {
                        return MobileView(
                          theme: theme,
                          report: report,
                          report2: report2,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
    super.key,
    required this.theme,
    required this.report,
    this.report2,
  });

  final ThemeProvider theme;
  final AnalysisReport report;
  final AnalysisReport? report2;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Expanded(
              child: StoresSectionWidget(
                theme: theme,
                report: report,
                report2: report2,
              ),
            ),
            Expanded(
              child: SubscriptionTodayWidget(
                theme: theme,
                report: report,
                report2: report2,
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Expanded(
              child: OthersSectionWidget(
                theme: theme,
                report: report,
                report2: report2,
              ),
            ),
            Expanded(
              child: SubscriptionGeneralWidget(
                theme: theme,
                report: report,
                report2: report2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MobileView extends StatelessWidget {
  const MobileView({
    super.key,
    required this.theme,
    required this.report,
    required this.report2,
  });

  final ThemeProvider theme;
  final AnalysisReport report;
  final AnalysisReport? report2;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        StoresSectionWidget(
          theme: theme,
          report: report,
          report2: report2,
        ),
        SubscriptionTodayWidget(
          theme: theme,
          report: report,
          report2: report2,
        ),
        SubscriptionGeneralWidget(
          theme: theme,
          report: report,
          report2: report2,
        ),
        OthersSectionWidget(
          theme: theme,
          report: report,
          report2: report2,
        ),
      ],
    );
  }
}
