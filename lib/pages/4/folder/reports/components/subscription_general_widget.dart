import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_details_main_sections.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_section_tile_widget.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class SubscriptionGeneralWidget extends StatelessWidget {
  const SubscriptionGeneralWidget({
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
      title: 'Subscriptions General',
      widget: [
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Subscribed',
          value: formatNumber(
            (report.totalSubscribedShops ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Free Plan Subscribers',
          value: formatNumber(
            (report.totalFreePlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Trials',
          value: formatNumber(
            (report.totalTrialSubscribers ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Basic Plan Subscribers',
          value: formatNumber(
            (report.totalBasicPlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Standard Plan Subscribers',
          value: formatNumber(
            (report.totalStandardPlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Premium Plan Subscribers',
          value: formatNumber(
            (report.totalPremiumPlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Silver Plan Subscribers',
          value: formatNumber(
            (report.totalSilverPlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'GOLD Plan Subscribers',
          value: formatNumber(
            (report.totalGoldPlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
      ],
    );
  }
}
