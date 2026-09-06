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
    required this.report2,
  });

  final ThemeProvider theme;
  final AnalysisReport report;
  final AnalysisReport? report2;

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
          value2: formatNumber(
            (report2?.totalSubscribedShops ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Free Plan Subscribers',
          value: formatNumber(
            (report.totalFreePlanSubscribers ?? 0)
                .toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalFreePlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Trials',
          value: formatNumber(
            (report.totalTrialSubscribers ?? 0).toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalTrialSubscribers ?? 0)
                .toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Basic Plan Subscribers',
          value: formatNumber(
            (report.totalBasicPlanSubscribers ?? 0)
                .toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalBasicPlanSubscribers ?? 0)
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
          value2: formatNumber(
            (report2?.totalStandardPlanSubscribers ?? 0)
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
          value2: formatNumber(
            (report2?.totalPremiumPlanSubscribers ?? 0)
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
          value2: formatNumber(
            (report2?.totalSilverPlanSubscribers ?? 0)
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
          value2: formatNumber(
            (report2?.totalGoldPlanSubscribers ?? 0)
                .toDouble(),
          ),
        ),
      ],
    );
  }
}
