import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:stockallagent/components/main_top_bar.dart';
import 'package:stockallagent/constants/constants_main.dart';
import 'package:stockallagent/main.dart';
import 'package:stockallagent/pages/4/folder/reports/report_details.dart';

class Reports extends StatefulWidget {
  final Function()? popPage;
  final Function()? profileNavAction;
  const Reports({
    super.key,
    this.profileNavAction,
    this.popPage,
  });

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        widget.popPage!();
      },
      child: Scaffold(
        body: Column(
          children: [
            MainTopBar(
              profileNavAction: widget.profileNavAction,
            ),
            SizedBox(height: 10),

            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 20.0,
            //   ),
            //   child: Container(
            //     padding: EdgeInsets.symmetric(
            //       vertical: 10,
            //       horizontal: 15,
            //     ),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(5),
            //       color: theme.lightModeColor.prColor300,
            //     ),
            //     child: Row(
            //       mainAxisAlignment:
            //           MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           spacing: 5,
            //           mainAxisAlignment:
            //               MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Total:',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: theme
            //                     .mobileTexts
            //                     .b4
            //                     .fontSize,
            //               ),
            //             ),
            //             Text(
            //               formatMoney(1000),
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: theme
            //                     .mobileTexts
            //                     .b2
            //                     .fontSize,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //         Row(
            //           spacing: 5,
            //           mainAxisAlignment:
            //               MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               'Net:',
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: theme
            //                     .mobileTexts
            //                     .b4
            //                     .fontSize,
            //               ),
            //             ),
            //             Text(
            //               formatMoney(1000),
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: theme
            //                     .mobileTexts
            //                     .b2
            //                     .fontSize,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () {
                  return returnReportProvider()
                      .getReports();
                },
                backgroundColor: Colors.white,
                color: theme.lightModeColor.prColor250,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  itemCount:
                      returnReportProvider().reports.length,
                  itemBuilder: (context, index) {
                    List<AnalysisReport> reports =
                        returnReportProvider().reports;
                    AnalysisReport report = reports[index];
                    AnalysisReport? report2() {
                      try {
                        return reports[index + 1];
                      } catch (e) {
                        return null;
                      }
                    }

                    return ReportTileMain(
                      report: report,
                      report2: report2(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportTileMain extends StatelessWidget {
  final AnalysisReport report;
  final AnalysisReport? report2;
  const ReportTileMain({
    super.key,
    required this.report,
    this.report2,
  });

  @override
  Widget build(BuildContext context) {
    var theme = returnTheme(context: context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border(
              bottom: BorderSide(
                color: Colors.grey.shade100,
              ),
            ),
          ),
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            borderRadius: BorderRadius.circular(5),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ReportDetails(
                      report: report,
                      report2: report2,
                    );
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Row(
                spacing: 10,
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      spacing: 8,
                      children: [
                        Icon(
                          size: 18,
                          color: Colors.grey,
                          Icons.book_outlined,
                        ),
                        Expanded(
                          child: Text(
                            style: TextStyle(
                              fontSize: theme
                                  .mobileTexts
                                  .b2
                                  .fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                            formatDateOrDaysAgo(
                              report.createdAt,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      // Text(
                      //   style: TextStyle(
                      //     fontSize:
                      //         theme.mobileTexts.b4.fontSize,
                      //   ),
                      //   formatNumber(
                      //     (report. ?? 0)
                      //         .toDouble(),
                      //   ),
                      // ),
                      Icon(
                        size: 14,
                        color: Colors.grey,
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
