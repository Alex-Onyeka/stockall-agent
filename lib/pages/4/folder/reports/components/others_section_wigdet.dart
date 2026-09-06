import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_details_main_sections.dart';
import 'package:stockallagent/pages/4/folder/reports/components/report_section_tile_widget.dart';
import 'package:stockallagent/theme/theme_provider.dart';

class OthersSectionWidget extends StatelessWidget {
  const OthersSectionWidget({
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
      title: 'Others',
      widget: [
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Sales',
          value: formatNumber(
            (report.totalSales ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Invoices',
          value: formatNumber(
            (report.totalInvoices ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'New Products',
          value: formatNumber(
            (report.totalProducts ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Expenses',
          value: formatNumber(
            (report.totalExpenses ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Customers',
          value: formatNumber(
            (report.totalCustomers ?? 0).toDouble(),
          ),
        ),
        ReportSectionTileWidget(
          theme: theme,
          title: 'Total Productions',
          value: formatNumber(
            (report.totalProductionRecords ?? 0).toDouble(),
          ),
        ),
      ],
    );
  }
}
