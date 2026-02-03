class ReportClass {
  final int id;
  final DateTime date;
  final double totalRevenue;
  final double totalNet;
  final double totalRefCut;
  final int subscribedStores;
  final int newStores;
  final List<int> newStoresId;
  final int totalHeadQuarters;
  final int totalStores;

  ReportClass({
    required this.id,
    required this.date,
    required this.totalRevenue,
    required this.totalNet,
    required this.totalRefCut,
    required this.subscribedStores,
    required this.newStores,
    required this.newStoresId,
    required this.totalHeadQuarters,
    required this.totalStores,
  });

  factory ReportClass.fromJson(Map<String, dynamic> json) {
    return ReportClass(
      id: json['id'] as int,
      date: DateTime.parse(json['created_at']),
      totalRevenue: (json['total_revenue'] as num)
          .toDouble(),
      totalNet: (json['total_net'] as num).toDouble(),
      totalRefCut: (json['total_ref_cut'] as num)
          .toDouble(),
      subscribedStores: json['subscribed_stores'] as int,
      newStores: json['new_stores'] as int,
      newStoresId: List<int>.from(json['new_stores_id']),
      totalHeadQuarters: json['total_headquarters'] as int,
      totalStores: json['total_stores'] as int,
    );
  }
}
