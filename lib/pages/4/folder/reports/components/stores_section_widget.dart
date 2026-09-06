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
  });

  final ThemeProvider theme;
  final AnalysisReport report;

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
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'New Headquarters',
          value: formatNumber(
            (report.totalShopsMain ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'New Branches',
          value: formatNumber(
            (report.totalShopsBranches ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Active',
          value: formatNumber(
            (report.totalActive ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Semi-Active',
          value: formatNumber(
            (report.totalSemiActive ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total In-Active',
          value: formatNumber(
            (report.totalInactive ?? 0).toDouble(),
          ),
        ),
      ],
    );
  }
}
