class RefPaymentsClass {
  final int? id;
  final DateTime? createdDate;
  final String userId;
  final double? amount;
  final double? monthTotal;
  final int? totalStores;

  RefPaymentsClass({
    this.id,
    this.createdDate,
    required this.userId,
    this.amount,
    this.monthTotal,
    this.totalStores,
  });

  factory RefPaymentsClass.fromJson(
    Map<String, dynamic> json,
  ) {
    return RefPaymentsClass(
      id: json['id'] as int,
      createdDate: DateTime.parse(
        json['created_at'] as String,
      ),
      userId: json['user_id'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      monthTotal: (json['month_total'] as num?)?.toDouble(),
      totalStores: json['total_stores'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'amount': amount,
      'month_total': monthTotal,
      'total_stores': totalStores,
    };
  }
}
