import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_details_main_sections.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_section_tile_widget.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class SubscriptionTodayWidget extends StatelessWidget {
  const SubscriptionTodayWidget({
    super.key,
    required this.theme,
    required this.report,
  });

  final ThemeProvider theme;
  final AnalysisReport report;

  @override
  Widget build(BuildContext context) {
    return ReportDetailsMainSection(
      theme: theme,
      title: 'Subscription (Today)',
      widget: [
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Subscriptions',
          value: formatNumber(
            (report.totalSubscriptions ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Free Plan',
          value: formatNumber(
            (report.totalFreePlan ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Basic Plan',
          value: formatNumber(
            (report.totalBasicPlan ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Standard Plan',
          value: formatNumber(
            (report.totalStandardPlan ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Premium Plan',
          value: formatNumber(
            (report.totalPremiumPlan ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Silver Plan',
          value: formatNumber(
            (report.totalSilverPlan ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'GOLD Plan',
          value: formatNumber(
            (report.totalGoldPlan ?? 0).toDouble(),
          ),
        ),
      ],
    );
  }
}
