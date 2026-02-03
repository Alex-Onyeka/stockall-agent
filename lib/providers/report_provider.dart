import 'package:flutter/material.dart';
import 'package:stockallagent/classes/report_class.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportProvider extends ChangeNotifier {
  final SupabaseClient _client = Supabase.instance.client;
  final String tableName = 'reports';

  List<ReportClass> reports = [];

  Future<List<ReportClass>> getReports() async {
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
          .map((re) => ReportClass.fromJson(re))
          .toList();

      notifyListeners();
      return reports;
    } catch (e) {
      print('❌Error Getting Reports ${e.toString()}');
      return [];
    }
  }

  double getTotalRevenue() {
    return reports
        .map((re) => re.totalRevenue)
        .toList()
        .fold(0, (value, element) => value + element);
  }

  double getTotalNetRevenue() {
    return reports
        .map((re) => re.totalNet)
        .toList()
        .fold(0, (value, element) => value + element);
  }

  double getTotalRefCut() {
    return reports
        .map((re) => re.totalRefCut)
        .toList()
        .fold(0, (value, element) => value + element);
  }

  ReportClass? getReportByMonth(DateTime date) {
    try {
      return reports.firstWhere(
        (re) =>
            re.date.year == date.year &&
            re.date.month == date.month,
      );
    } catch (e) {
      return null;
    }
  }
}
