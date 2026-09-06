import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_details_main_sections.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_section_tile_widget.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class StoresSectionWidget extends StatelessWidget {
  const StoresSectionWidget({
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
      title: 'Stores',
      widget: [
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total New',
          value: formatNumber(report.getTotalShops()),
          value2: formatNumber(
            report2?.getTotalShops() ?? 0,
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'New Headquarters',
          value: formatNumber(
            (report.totalShopsMain ?? 0).toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalShopsMain ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'New Branches',
          value: formatNumber(
            (report.totalShopsBranches ?? 0).toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalShopsBranches ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Active',
          value: formatNumber(
            (report.totalActive ?? 0).toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalActive ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Semi-Active',
          value: formatNumber(
            (report.totalSemiActive ?? 0).toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalSemiActive ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total In-Active',
          value: formatNumber(
            (report.totalInactive ?? 0).toDouble(),
          ),
          value2: formatNumber(
            (report2?.totalInactive ?? 0).toDouble(),
          ),
        ),
      ],
    );
  }
}
