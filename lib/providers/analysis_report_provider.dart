import 'package:flutter/material.dart';
import 'package:stockallagent/classes/analysis_report.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportProvider extends ChangeNotifier {
  static final ReportProvider _instance =
      ReportProvider._internal();
  factory ReportProvider() => _instance;
  ReportProvider._internal();
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'analysis_report';
  List<AnalysisReport> reports = [];

  Future<List<AnalysisReport>> getReports() async {
    try {
      var res = await _client.from(tableName).select();
      if (res.isEmpty) {
        print('No Reports Gotten');
        reports = [];
        notifyListeners();
        return [];
      }
      print('✅Reports Gotten Successfully');
      reports = res
          .map((re) => AnalysisReport.fromJson(re))
          .toList();
      reports.sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
      notifyListeners();
      return reports;
    } catch (e) {
      print('❌Error Getting Reports ${e.toString()}');
      return [];
    }
  }

  AnalysisReport? getReportByMonth(DateTime date) {
    try {
      return reports.firstWhere(
        (re) =>
            re.createdAt.year == date.year &&
            re.createdAt.month == date.month,
      );
    } catch (e) {
      return null;
    }
  }
}
